import 'package:assiette/features/environment_capture/domain/device_location.dart';

/// Desired interval between environment captures.
///
/// Android may defer periodic work to batch wake-ups and preserve battery.
const environmentCaptureInterval = Duration(hours: 3);

/// Maximum age of a cached fix before a fresh low-power fix is requested.
const environmentLocationMaxAge = Duration(hours: 3);

/// Maximum time spent waiting for a fresh low-power location fix.
const environmentLocationTimeout = Duration(seconds: 15);

/// Two fixes inside this radius represent the same weather area.
const environmentWeatherZoneRadiusMetres = 10000.0;

/// Maximum distance in time from both edges of a missing day for backfill.
const environmentBackfillAnchorMaxGap = Duration(hours: 12);

/// Whether [location] is recent enough to use without activating sensors.
bool isEnvironmentLocationFresh(
  DeviceLocation location,
  DateTime now, {
  Duration maxAge = environmentLocationMaxAge,
}) {
  final age = now.toUtc().difference(location.timestamp.toUtc());
  return !age.isNegative && age <= maxAge;
}

/// Whether two locations belong to the same coarse weather area.
bool isSameEnvironmentWeatherZone(
  DeviceLocation first,
  DeviceLocation second,
) => first.distanceTo(second) <= environmentWeatherZoneRadiusMetres;
