import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

/// Resolves a coarse device position for background weather capture.
///
/// Kept as an interface, not a top-level function, so tests can inject a
/// fake without touching the real geolocator plugin.
abstract class LocationReader {
  /// Returns the device's position, or `null` if location is unavailable
  /// (services disabled, permission denied, or no fix could be obtained).
  Future<Position?> readPosition();

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
/// Prefers the last known position (cheap, no GPS fix) and only falls back
/// to a fresh low-accuracy fix when no cached position exists.
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
  Future<Position?> readPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    final lastKnown = await Geolocator.getLastKnownPosition();
    if (lastKnown != null) return lastKnown;

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );
    } on Exception {
      return null;
    }
  }
}
