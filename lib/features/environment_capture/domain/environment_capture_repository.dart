import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/environment_capture/data/environment_capture_repository.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'environment_capture_repository.g.dart';

/// Captures a weather/pressure snapshot for the device's current location.
///
/// Repository contracts in this codebase are always abstract classes, even
/// with a single method, to keep dependency injection and testing consistent
/// with the rest of the domain layer.
// ignore: one_member_abstracts
abstract class EnvironmentCaptureRepository {
  /// Resolves the device's location, fetches current conditions from
  /// Open-Meteo and stores a new environment snapshot.
  ///
  /// Returns `true` on success, `false` if the snapshot could not be
  /// captured (no location, no network, ...). Never throws.
  Future<bool> captureSnapshot();
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
