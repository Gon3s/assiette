import 'package:geocoding/geocoding.dart' as geocoding;

/// Resolves a human-readable place name (city/town) from coordinates.
///
/// Kept as an interface, not a top-level function, so tests can inject a
/// fake without touching the real geocoding plugin.
// ignore: one_member_abstracts
abstract class LocalityResolver {
  /// Returns the locality name for the given coordinates, or `null` when
  /// it cannot be resolved (no network, no geocoder...). Never throws.
  Future<String?> resolveLocality({
    required double latitude,
    required double longitude,
  });
}

/// [LocalityResolver] backed by the platform geocoder (`geocoding` plugin).
///
/// Results are memoized per ~1 km grid cell: the header re-requests the
/// locality on every new snapshot, and the place rarely changes.
class GeocodingLocalityResolver implements LocalityResolver {
  final _cache = <String, String?>{};

  @override
  Future<String?> resolveLocality({
    required double latitude,
    required double longitude,
  }) async {
    final key =
        '${latitude.toStringAsFixed(2)},${longitude.toStringAsFixed(2)}';
    if (_cache.containsKey(key)) return _cache[key];

    String? locality;
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        locality = [
          placemark.locality,
          placemark.subAdministrativeArea,
          placemark.administrativeArea,
        ].firstWhere(
          (name) => name != null && name.isNotEmpty,
          orElse: () => null,
        );
      }
    } on Exception {
      locality = null;
    }
    return _cache[key] = locality;
  }
}
