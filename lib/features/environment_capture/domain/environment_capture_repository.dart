import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/environment_capture/data/environment_capture_repository.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:assiette/features/environment_capture/domain/device_location.dart';
import 'package:assiette/features/environment_capture/domain/hourly_measure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'environment_capture_repository.g.dart';

/// Captures weather/pressure/air-quality snapshots for the device's
/// current location.
abstract class EnvironmentCaptureRepository {
  /// Resolves the device's location, fetches current conditions from
  /// Open-Meteo and stores a new environment snapshot.
  ///
  /// Returns `true` on success, `false` if the snapshot could not be
  /// captured (no location, no network, ...). Never throws.
  Future<bool> captureSnapshot({DeviceLocation? location});

  /// Fills past days that have no snapshot at all with hourly values from
  /// Open-Meteo only when nearby snapshots confirm a stable weather zone.
  ///
  /// Looks back [days] days before today. Returns the number of days
  /// backfilled. Never throws.
  Future<int> backfillMissingDays({int days});

  /// Hourly pressure forecast with timestamps (today + tomorrow, local
  /// time) for the given coordinates. Throws on network/API failure.
  Future<List<HourlyMeasure>> pressureForecastSeries({
    required double latitude,
    required double longitude,
  });
}

/// Provides the [EnvironmentCaptureRepository] implementation.
@riverpod
EnvironmentCaptureRepository environmentCaptureRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftEnvironmentCaptureRepository(
    environmentDao: db.environmentDao,
    locationReader: GeolocatorLocationReader(),
    openMeteoClient: OpenMeteoClient(),
  );
}
