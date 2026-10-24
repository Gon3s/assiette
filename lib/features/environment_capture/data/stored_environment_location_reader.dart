import 'package:assiette/data/daos/environment_dao.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/domain/device_location.dart';

/// Background weather uses the last recorded place, never Android location APIs.
class StoredEnvironmentLocationReader implements LocationReader {
  StoredEnvironmentLocationReader({
    required this._environmentDao,
    required this._canUseLocation,
  });

  final EnvironmentDao _environmentDao;
  final Future<bool> Function() _canUseLocation;

  @override
  Future<bool> ensurePermission() => _canUseLocation();

  @override
  Future<DeviceLocation?> readPosition() async {
    if (!await _canUseLocation()) return null;
    final snapshot = await _environmentDao.getLatest();
    final lat = snapshot?.lat;
    final lon = snapshot?.lon;
    if (snapshot == null || lat == null || lon == null) return null;
    return DeviceLocation(
      latitude: lat,
      longitude: lon,
      timestamp: snapshot.timestamp,
    );
  }
}
