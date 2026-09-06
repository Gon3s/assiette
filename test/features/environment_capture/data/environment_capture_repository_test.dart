import 'dart:convert';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/environment_capture/data/environment_capture_repository.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:assiette/features/environment_capture/domain/device_location.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class _FakeLocationReader implements LocationReader {
  _FakeLocationReader(this._position);

  final DeviceLocation? _position;

  @override
  Future<bool> ensurePermission() async => _position != null;

  @override
  Future<DeviceLocation?> readPosition() async => _position;
}

DeviceLocation _position({
  double lat = 45.75,
  double lon = 4.85,
  DateTime? timestamp,
}) => DeviceLocation(
  latitude: lat,
  longitude: lon,
  timestamp: timestamp ?? DateTime.utc(2026, 7, 6),
);

OpenMeteoClient _openMeteoClientReturning({
  double? pressure,
  double? surfacePressure,
  double? temperature,
  double? humidity,
  int? weatherCode,
  double? uvIndex,
  double? pm25,
  double? grassPollen,
}) => OpenMeteoClient(
  httpClient: MockClient(
    (request) async {
      if (request.url.host == 'air-quality-api.open-meteo.com') {
        return http.Response(
          jsonEncode({
            'current': {
              'pm2_5': pm25,
              'grass_pollen': grassPollen,
            },
          }),
          200,
        );
      }
      return http.Response(
        jsonEncode({
          'current': {
            'pressure_msl': pressure,
            'surface_pressure': surfacePressure,
            'temperature_2m': temperature,
            'relative_humidity_2m': humidity,
            'weather_code': weatherCode,
            'uv_index': uvIndex,
          },
        }),
        200,
      );
    },
  ),
);

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  group('DriftEnvironmentCaptureRepository', () {
    test('returns false when no location is available', () async {
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(null),
        openMeteoClient: _openMeteoClientReturning(pressure: 1013),
      );

      final captured = await repository.captureSnapshot();

      expect(captured, isFalse);
      expect(await db.environmentDao.getLatest(), isNull);
    });

    test('returns false and stores nothing when the API call fails', () async {
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: OpenMeteoClient(
          httpClient: MockClient(
            (request) async => http.Response('', 500),
          ),
        ),
      );

      final captured = await repository.captureSnapshot();

      expect(captured, isFalse);
      expect(await db.environmentDao.getLatest(), isNull);
    });

    test('stores a snapshot with the resolved position and reading', () async {
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning(
          pressure: 1013,
          temperature: 21.5,
          humidity: 60,
          weatherCode: 3,
          uvIndex: 5.1,
          pm25: 9.2,
          grassPollen: 30,
        ),
      );

      final captured = await repository.captureSnapshot();

      expect(captured, isTrue);
      final snapshot = await db.environmentDao.getLatest();
      expect(snapshot?.pressure, 1013);
      expect(snapshot?.pressureDelta, isNull);
      expect(snapshot?.temperature, 21.5);
      expect(snapshot?.humidity, 60);
      expect(snapshot?.lat, 45.75);
      expect(snapshot?.lon, 4.85);
      expect(snapshot?.weatherCode, 3);
      expect(snapshot?.uvIndex, 5.1);
      expect(snapshot?.pm25, 9.2);
      expect(snapshot?.grassPollen, 30);
    });

    test('still stores the weather snapshot when air quality fails', () async {
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: OpenMeteoClient(
          httpClient: MockClient((request) async {
            if (request.url.host == 'air-quality-api.open-meteo.com') {
              return http.Response('', 500);
            }
            return http.Response(
              jsonEncode({
                'current': {'pressure_msl': 1013.0},
              }),
              200,
            );
          }),
        ),
      );

      final captured = await repository.captureSnapshot();

      expect(captured, isTrue);
      final snapshot = await db.environmentDao.getLatest();
      expect(snapshot?.pressure, 1013);
      expect(snapshot?.pm25, isNull);
    });

    test('computes pressure delta against the previous snapshot', () async {
      var now = DateTime.utc(2026, 7, 6, 9);
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning(pressure: 1013),
        now: () => now,
      );
      await repository.captureSnapshot();

      now = now.add(const Duration(hours: 3));
      final second = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning(pressure: 1009),
        now: () => now,
      );
      await second.captureSnapshot();

      final snapshot = await db.environmentDao.getLatest();
      expect(snapshot?.pressure, 1009);
      expect(snapshot?.pressureDelta, -4);
    });

    test('deduplicates a fresh snapshot in the same weather zone', () async {
      var apiCalls = 0;
      final client = OpenMeteoClient(
        httpClient: MockClient((request) async {
          apiCalls++;
          return http.Response(
            jsonEncode({
              'current': {'pressure_msl': 1013.0},
            }),
            200,
          );
        }),
      );
      final now = DateTime.utc(2026, 7, 6, 9);
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: client,
        now: () => now,
      );

      expect(await repository.captureSnapshot(), isTrue);
      expect(await repository.captureSnapshot(), isFalse);
      expect(apiCalls, 2); // Weather + air quality for the first capture only.
    });

    test(
      'captures immediately after changing zone and resets pressure delta',
      () async {
        final now = DateTime.utc(2026, 7, 6, 9);
        final first = DriftEnvironmentCaptureRepository(
          environmentDao: db.environmentDao,
          locationReader: _FakeLocationReader(_position()),
          openMeteoClient: _openMeteoClientReturning(pressure: 1013),
          now: () => now,
        );
        await first.captureSnapshot();

        final moved = DriftEnvironmentCaptureRepository(
          environmentDao: db.environmentDao,
          locationReader: _FakeLocationReader(_position(lat: 48.86, lon: 2.35)),
          openMeteoClient: _openMeteoClientReturning(pressure: 1000),
          now: () => now.add(const Duration(minutes: 5)),
        );

        expect(await moved.captureSnapshot(), isTrue);
        final snapshot = await db.environmentDao.getLatest();
        expect(snapshot?.lat, 48.86);
        expect(snapshot?.pressureDelta, isNull);
      },
    );

    test(
      'falls back to surface pressure when sea-level pressure is missing',
      () async {
        final repository = DriftEnvironmentCaptureRepository(
          environmentDao: db.environmentDao,
          locationReader: _FakeLocationReader(_position()),
          openMeteoClient: _openMeteoClientReturning(surfacePressure: 998),
        );

        await repository.captureSnapshot();

        final snapshot = await db.environmentDao.getLatest();
        expect(snapshot?.pressure, 998);
      },
    );
  });

  group('DriftEnvironmentCaptureRepository.backfillMissingDays', () {
    OpenMeteoClient historyClient(List<DateTime> times) => OpenMeteoClient(
      httpClient: MockClient(
        (request) async => http.Response(
          jsonEncode({
            'hourly': {
              'time': [for (final t in times) t.toIso8601String()],
              'pressure_msl': [
                for (var i = 0; i < times.length; i++) 1010.0 + i,
              ],
              'temperature_2m': [
                for (var i = 0; i < times.length; i++) 20.0,
              ],
              'relative_humidity_2m': [
                for (var i = 0; i < times.length; i++) 65,
              ],
              'weather_code': [
                for (var i = 0; i < times.length; i++) 2,
              ],
              'uv_index': [
                for (var i = 0; i < times.length; i++) 3.0,
              ],
            },
          }),
          200,
        ),
      ),
    );

    test('fills days without any snapshot and skips today', () async {
      final now = DateTime(2026, 7, 10, 12);
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      await db.environmentDao.insertSnapshot(
        EnvironmentSnapshotsCompanion.insert(
          id: 'before',
          timestamp: yesterday.subtract(const Duration(hours: 4)).toUtc(),
          lat: const Value(45.75),
          lon: const Value(4.85),
        ),
      );
      await db.environmentDao.insertSnapshot(
        EnvironmentSnapshotsCompanion.insert(
          id: 'after',
          timestamp: today.add(const Duration(hours: 4)).toUtc(),
          lat: const Value(45.76),
          lon: const Value(4.86),
        ),
      );

      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: historyClient([
          yesterday,
          yesterday.add(const Duration(hours: 1)),
          today,
          today.add(const Duration(hours: 1)),
        ]),
        now: () => now,
      );

      final filledDays = await repository.backfillMissingDays();

      expect(filledDays, 1);
      final stored = await db.environmentDao.getRange(
        yesterday.toUtc(),
        today.add(const Duration(days: 1)).toUtc(),
      );
      expect(stored, hasLength(3));
      expect(stored[1].temperature, 20.0);
      expect(stored[1].weatherCode, 2);
      // Delta computed within the backfilled series (1011.0 - 1010.0).
      expect(stored[1].pressureDelta, 1.0);
    });

    test('does not duplicate a day that already has data and reuses its '
        'coordinates when no location is available', () async {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      await db.environmentDao.insertSnapshot(
        EnvironmentSnapshotsCompanion.insert(
          id: 'existing',
          timestamp: yesterday.add(const Duration(hours: 12)).toUtc(),
          pressure: const Value(1000),
          lat: const Value(45.75),
          lon: const Value(4.85),
        ),
      );

      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(null),
        openMeteoClient: historyClient([
          yesterday,
          yesterday.add(const Duration(hours: 1)),
        ]),
        now: () => now,
      );

      final filledDays = await repository.backfillMissingDays();

      expect(filledDays, 0);
      final stored = await db.environmentDao.getRange(
        yesterday.toUtc(),
        today.toUtc(),
      );
      expect(stored, hasLength(1));
    });

    test('does not backfill without stored location anchors', () async {
      final now = DateTime(2026, 7, 10, 12);
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(null),
        openMeteoClient: historyClient(const []),
        now: () => now,
      );

      expect(await repository.backfillMissingDays(), 0);
    });

    test(
      'does not backfill a day bracketed by different weather zones',
      () async {
        final now = DateTime(2026, 7, 10, 12);
        final today = DateTime(now.year, now.month, now.day);
        final yesterday = today.subtract(const Duration(days: 1));
        await db.environmentDao.insertSnapshot(
          EnvironmentSnapshotsCompanion.insert(
            id: 'lyon-before',
            timestamp: yesterday.subtract(const Duration(hours: 4)).toUtc(),
            lat: const Value(45.75),
            lon: const Value(4.85),
          ),
        );
        await db.environmentDao.insertSnapshot(
          EnvironmentSnapshotsCompanion.insert(
            id: 'paris-after',
            timestamp: today.add(const Duration(hours: 4)).toUtc(),
            lat: const Value(48.86),
            lon: const Value(2.35),
          ),
        );
        final repository = DriftEnvironmentCaptureRepository(
          environmentDao: db.environmentDao,
          locationReader: _FakeLocationReader(null),
          openMeteoClient: historyClient([
            yesterday,
            yesterday.add(const Duration(hours: 1)),
          ]),
          now: () => now,
        );

        expect(await repository.backfillMissingDays(), 0);
        expect(
          await db.environmentDao.getRange(yesterday.toUtc(), today.toUtc()),
          isEmpty,
        );
      },
    );
  });
}
