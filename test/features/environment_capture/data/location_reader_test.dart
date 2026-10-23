import 'dart:async';

import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_policy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';

class _MockGeolocator extends Mock implements GeolocatorPlatform {}

Position _position(DateTime timestamp) => Position(
  latitude: 45.75,
  longitude: 4.85,
  timestamp: timestamp,
  accuracy: 3000,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

void main() {
  late _MockGeolocator platform;
  late bool visible;
  late GeolocatorLocationReader reader;

  setUpAll(() => registerFallbackValue(const LocationSettings()));
  setUp(() {
    visible = true;
    platform = _MockGeolocator();
    when(platform.isLocationServiceEnabled).thenAnswer((_) async => true);
    when(
      platform.checkPermission,
    ).thenAnswer((_) async => LocationPermission.whileInUse);
    when(() => platform.getLastKnownPosition()).thenAnswer((_) async => null);
    reader = GeolocatorLocationReader(
      geolocator: platform,
      isForeground: () => visible,
    );
  });

  test(
    'while-in-use consent is sufficient without requesting more access',
    () async {
      expect(await reader.ensurePermission(), isTrue);
      verifyNever(platform.requestPermission);
    },
  );

  test('requests only foreground consent after an explicit action', () async {
    when(
      platform.checkPermission,
    ).thenAnswer((_) async => LocationPermission.denied);
    when(
      platform.requestPermission,
    ).thenAnswer((_) async => LocationPermission.whileInUse);
    expect(await reader.ensurePermission(), isTrue);
    verify(platform.requestPermission).called(1);
  });

  for (final permission in [
    LocationPermission.deniedForever,
    LocationPermission.unableToDetermine,
  ]) {
    test('does not prompt for $permission', () async {
      when(platform.checkPermission).thenAnswer((_) async => permission);
      expect(await reader.ensurePermission(), isFalse);
      verifyNever(platform.requestPermission);
    });
  }

  test(
    'never requests consent or reads Android location while not visible',
    () async {
      visible = false;
      expect(await reader.ensurePermission(), isFalse);
      expect(await reader.readPosition(), isNull);
      verifyZeroInteractions(platform);
    },
  );

  test('a passive capture never prompts after denial', () async {
    when(
      platform.checkPermission,
    ).thenAnswer((_) async => LocationPermission.denied);
    expect(await reader.readPosition(), isNull);
    verifyNever(platform.requestPermission);
    verifyNever(() => platform.getLastKnownPosition());
    verifyNever(
      () => platform.getCurrentPosition(
        locationSettings: any(named: 'locationSettings'),
      ),
    );
  });

  test('disabled location services prevent capture and prompts', () async {
    when(platform.isLocationServiceEnabled).thenAnswer((_) async => false);
    expect(await reader.ensurePermission(), isFalse);
    expect(await reader.readPosition(), isNull);
    verifyNever(platform.requestPermission);
  });

  test('reuses a recent cached position without a new fix', () async {
    when(
      () => platform.getLastKnownPosition(),
    ).thenAnswer((_) async => _position(DateTime.now()));
    expect((await reader.readPosition())?.latitude, 45.75);
    verifyNever(
      () => platform.getCurrentPosition(
        locationSettings: any(named: 'locationSettings'),
      ),
    );
  });

  test('requests only low accuracy when the cache is stale', () async {
    when(
      () => platform.getLastKnownPosition(),
    ).thenAnswer((_) async => _position(DateTime.utc(2020)));
    when(
      () => platform.getCurrentPosition(
        locationSettings: any(named: 'locationSettings'),
      ),
    ).thenAnswer((_) async => _position(DateTime.now()));
    expect(await reader.readPosition(), isNotNull);
    final settings =
        verify(
              () => platform.getCurrentPosition(
                locationSettings: captureAny(named: 'locationSettings'),
              ),
            ).captured.single
            as LocationSettings;
    expect(settings.accuracy, LocationAccuracy.low);
    expect(settings.timeLimit, environmentLocationTimeout);
  });

  test('discards a pending fix if the app loses visibility', () async {
    final fix = Completer<Position>();
    final started = Completer<void>();
    when(
      () => platform.getCurrentPosition(
        locationSettings: any(named: 'locationSettings'),
      ),
    ).thenAnswer((_) {
      started.complete();
      return fix.future;
    });
    final result = reader.readPosition();
    await started.future;
    visible = false;
    fix.complete(_position(DateTime.now()));
    expect(await result, isNull);
  });

  test(
    'background permission checks do not request consent or a position',
    () async {
      visible = false;
      expect(await reader.hasPermission(), isTrue);
      verifyNever(platform.requestPermission);
      verifyNever(() => platform.getLastKnownPosition());
      verifyNever(
        () => platform.getCurrentPosition(
          locationSettings: any(named: 'locationSettings'),
        ),
      );
    },
  );
}
