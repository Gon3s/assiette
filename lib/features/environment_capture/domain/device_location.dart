import 'dart:math' as math;

/// Coarse device location used to associate environment data with a place.
///
/// Keeping this value independent from the geolocator plugin makes the
/// capture repositories deterministic and easy to test.
class DeviceLocation {
  /// Creates a device location.
  const DeviceLocation({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  /// Latitude in decimal degrees.
  final double latitude;

  /// Longitude in decimal degrees.
  final double longitude;

  /// Time at which the location fix was obtained.
  final DateTime timestamp;

  /// Great-circle distance to [other], in metres.
  double distanceTo(DeviceLocation other) {
    const earthRadiusMetres = 6371000.0;
    final latitudeDelta = _radians(other.latitude - latitude);
    final longitudeDelta = _radians(other.longitude - longitude);
    final startLatitude = _radians(latitude);
    final endLatitude = _radians(other.latitude);
    final a =
        math.sin(latitudeDelta / 2) * math.sin(latitudeDelta / 2) +
        math.cos(startLatitude) *
            math.cos(endLatitude) *
            math.sin(longitudeDelta / 2) *
            math.sin(longitudeDelta / 2);
    return earthRadiusMetres * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  }

  static double _radians(double degrees) => degrees * math.pi / 180;
}
