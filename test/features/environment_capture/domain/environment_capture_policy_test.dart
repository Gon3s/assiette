import 'package:assiette/features/environment_capture/domain/device_location.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_policy.dart';
import 'package:flutter_test/flutter_test.dart';

DeviceLocation _location({
  required DateTime timestamp,
  double latitude = 45.75,
  double longitude = 4.85,
}) => DeviceLocation(
  latitude: latitude,
  longitude: longitude,
  timestamp: timestamp,
);

void main() {
  group('environment location policy', () {
    test('accepts a cached location up to three hours old', () {
      final now = DateTime.utc(2026, 9, 6, 12);

      expect(
        isEnvironmentLocationFresh(
          _location(timestamp: now.subtract(const Duration(hours: 3))),
          now,
        ),
        isTrue,
      );
    });

    test('rejects stale and future cached locations', () {
      final now = DateTime.utc(2026, 9, 6, 12);

      expect(
        isEnvironmentLocationFresh(
          _location(
            timestamp: now.subtract(const Duration(hours: 3, seconds: 1)),
          ),
          now,
        ),
        isFalse,
      );
      expect(
        isEnvironmentLocationFresh(
          _location(timestamp: now.add(const Duration(minutes: 1))),
          now,
        ),
        isFalse,
      );
    });

    test('uses a coarse ten-kilometre weather zone', () {
      final now = DateTime.utc(2026, 9, 6, 12);
      final lyon = _location(timestamp: now);
      final nearby = _location(
        latitude: 45.78,
        longitude: 4.9,
        timestamp: now,
      );
      final paris = _location(
        latitude: 48.86,
        longitude: 2.35,
        timestamp: now,
      );

      expect(isSameEnvironmentWeatherZone(lyon, nearby), isTrue);
      expect(isSameEnvironmentWeatherZone(lyon, paris), isFalse);
    });
  });
}
