import 'dart:convert';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/environment_capture/data/environment_capture_repository.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class _FakeLocationReader implements LocationReader {
  _FakeLocationReader(this._position);

  final Position? _position;

  @override
  Future<Position?> readPosition() async => _position;
}

Position _position({double lat = 45.75, double lon = 4.85}) => Position(
      latitude: lat,
      longitude: lon,
      timestamp: DateTime(2026, 7, 6),
      accuracy: 50,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );

OpenMeteoClient _openMeteoClientReturning({
  double? pressure,
  double? surfacePressure,
  double? temperature,
  double? humidity,
}) =>
    OpenMeteoClient(
      httpClient: MockClient(
        (request) async => http.Response(
          jsonEncode({
            'current': {
              'pressure_msl': pressure,
              'surface_pressure': surfacePressure,
              'temperature_2m': temperature,
              'relative_humidity_2m': humidity,
            },
          }),
          200,
        ),
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

    test('returns false and stores nothing when the API call fails',
        () async {
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

    test('stores a snapshot with the resolved position and reading',
        () async {
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning(
          pressure: 1013,
          temperature: 21.5,
          humidity: 60,
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
    });

    test('computes pressure delta against the previous snapshot', () async {
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning(pressure: 1013),
      );
      await repository.captureSnapshot();

      final second = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning(pressure: 1009),
      );
      await second.captureSnapshot();

      final snapshot = await db.environmentDao.getLatest();
      expect(snapshot?.pressure, 1009);
      expect(snapshot?.pressureDelta, -4);
    });

    test('falls back to surface pressure when sea-level pressure is missing',
        () async {
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning(surfacePressure: 998),
      );

      await repository.captureSnapshot();

      final snapshot = await db.environmentDao.getLatest();
      expect(snapshot?.pressure, 998);
    });
  });
}
