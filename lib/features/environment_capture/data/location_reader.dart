import 'package:assiette/features/environment_capture/domain/device_location.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_policy.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

/// Resolves an approximate place for weather capture.
///
/// Kept as an interface, not a top-level function, so tests can inject a
/// fake without touching the real geolocator plugin.
abstract class LocationReader {
  /// Returns the device's position, or `null` if location is unavailable
  /// (services disabled, permission denied, or no fix could be obtained).
  Future<DeviceLocation?> readPosition();

  /// Requests approximate, while-in-use access after an explicit user action.
  Future<bool> ensurePermission();
}

/// [LocationReader] backed by the `geolocator` plugin.
///
/// Prefers a recent last known position (cheap, no GPS fix) and only falls
/// back to a fresh low-accuracy fix when the cache is absent or stale.
class GeolocatorLocationReader implements LocationReader {
  GeolocatorLocationReader({
    GeolocatorPlatform? geolocator,
    bool Function()? isForeground,
  }) : _geolocator = geolocator ?? GeolocatorPlatform.instance,
       _isForeground = isForeground ?? _appIsForeground;

  final GeolocatorPlatform _geolocator;
  final bool Function() _isForeground;

  static bool _appIsForeground() =>
      WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;

  /// Checks existing consent without opening a prompt or reading a position.
  Future<bool> hasPermission() async {
    if (!await _geolocator.isLocationServiceEnabled()) return false;
    return _isGranted(await _geolocator.checkPermission());
  }

  static bool _isGranted(LocationPermission permission) =>
      permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always;

  @override
  Future<bool> ensurePermission() async {
    if (!_isForeground()) return false;
    final serviceEnabled = await _geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    var permission = await _geolocator.checkPermission();
    if (permission == LocationPermission.denied && _isForeground()) {
      permission = await _geolocator.requestPermission();
    }
    return _isGranted(permission);
  }

  @override
  Future<DeviceLocation?> readPosition() async {
    if (!_isForeground() || !await hasPermission() || !_isForeground()) {
      return null;
    }

    final lastKnown = await _geolocator.getLastKnownPosition();
    if (!_isForeground()) return null;
    if (lastKnown != null) {
      final cached = _toDeviceLocation(lastKnown);
      if (isEnvironmentLocationFresh(cached, DateTime.now())) return cached;
    }

    try {
      final current = await _geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: environmentLocationTimeout,
        ),
      );
      return _isForeground() ? _toDeviceLocation(current) : null;
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
