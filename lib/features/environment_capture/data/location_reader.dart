import 'package:assiette/features/environment_capture/domain/device_location.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_policy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

/// Resolves a coarse device position for background weather capture.
///
/// Kept as an interface, not a top-level function, so tests can inject a
/// fake without touching the real geolocator plugin.
abstract class LocationReader {
  /// Returns the device's position, or `null` if location is unavailable
  /// (services disabled, permission denied, or no fix could be obtained).
  Future<DeviceLocation?> readPosition();

  /// Requests the location permissions needed for background capture.
  ///
  /// Must be called while the app has a foreground activity (the OS won't
  /// show the permission dialog otherwise): first the regular "while in
  /// use" permission, then - only if that is granted - the "always allow"
  /// permission required to read the position from the periodic background
  /// task. Returns `true` if at least the "while in use" permission ends up
  /// granted.
  Future<bool> ensurePermission();
}

/// [LocationReader] backed by the `geolocator` plugin.
///
/// Prefers a recent last known position (cheap, no GPS fix) and only falls
/// back to a fresh low-accuracy fix when the cache is absent or stale.
class GeolocatorLocationReader implements LocationReader {
  @override
  Future<bool> ensurePermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }

    // Requested separately from the "while in use" permission above: Android
    // 11+ silently denies "always" if it's requested in the same prompt.
    await ph.Permission.locationAlways.request();

    return true;
  }

  @override
  Future<DeviceLocation?> readPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    final lastKnown = await Geolocator.getLastKnownPosition();
    if (lastKnown != null) {
      final cached = _toDeviceLocation(lastKnown);
      if (isEnvironmentLocationFresh(cached, DateTime.now())) return cached;
    }

    try {
      final current = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: environmentLocationTimeout,
        ),
      );
      return _toDeviceLocation(current);
    } on Exception {
      return null;
    }
  }

  static DeviceLocation _toDeviceLocation(Position position) => DeviceLocation(
    latitude: position.latitude,
    longitude: position.longitude,
    timestamp: position.timestamp,
  );
}
