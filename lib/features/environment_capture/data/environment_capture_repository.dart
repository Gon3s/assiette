import 'package:assiette/data/daos/environment_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_repository.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [EnvironmentCaptureRepository].
class DriftEnvironmentCaptureRepository implements EnvironmentCaptureRepository {
  /// Creates a [DriftEnvironmentCaptureRepository] backed by the given
  /// collaborators.
  DriftEnvironmentCaptureRepository({
    required EnvironmentDao environmentDao,
    required LocationReader locationReader,
    required OpenMeteoClient openMeteoClient,
  })  : _environmentDao = environmentDao,
        _locationReader = locationReader,
        _openMeteoClient = openMeteoClient;

  final EnvironmentDao _environmentDao;
  final LocationReader _locationReader;
  final OpenMeteoClient _openMeteoClient;

  static const _uuid = Uuid();

  @override
  Future<bool> captureSnapshot() async {
    try {
      final position = await _locationReader.readPosition();
      if (position == null) return false;

      final reading = await _openMeteoClient.fetchCurrent(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      final pressure = reading.pressure ?? reading.surfacePressure;
      final previous = await _environmentDao.getLatest();
      final pressureDelta = (pressure != null && previous?.pressure != null)
          ? pressure - previous!.pressure!
          : null;

      await _environmentDao.insertSnapshot(
        EnvironmentSnapshotsCompanion.insert(
          id: _uuid.v4(),
          timestamp: DateTime.now().toUtc(),
          pressure: Value(pressure),
          pressureDelta: Value(pressureDelta),
          temperature: Value(reading.temperature),
          humidity: Value(reading.humidity),
          lat: Value(position.latitude),
          lon: Value(position.longitude),
        ),
      );
      return true;
    } on Exception {
      return false;
    }
  }
}
