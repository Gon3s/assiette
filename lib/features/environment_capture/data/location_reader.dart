import 'package:geolocator/geolocator.dart';

/// Resolves a coarse device position for background weather capture.
///
/// Kept as an interface, not a top-level function, so tests can inject a
/// fake without touching the real geolocator plugin.
// ignore: one_member_abstracts
abstract class LocationReader {
  /// Returns the device's position, or `null` if location is unavailable
  /// (services disabled, permission denied, or no fix could be obtained).
  Future<Position?> readPosition();
}

/// [LocationReader] backed by the `geolocator` plugin.
///
/// Prefers the last known position (cheap, no GPS fix) and only falls back
/// to a fresh low-accuracy fix when no cached position exists.
class GeolocatorLocationReader implements LocationReader {
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
