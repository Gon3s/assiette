import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/menstrual_tracking/data/drift_menstrual_tracking_repository.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menstrual_tracking_repository.g.dart';

abstract class MenstrualTrackingRepository {
  Stream<MenstrualPreferences> watchPreferences();
  Future<MenstrualPreferences> getPreferences();
  Future<void> setPreferences(MenstrualPreferences preferences);
  Stream<MenstrualObservation?> watchDay(String date);
  Future<List<MenstrualObservation>> getRange(String start, String end);
  Future<void> save(MenstrualObservation observation);
  Future<void> delete(String date);
  Future<void> purge();
}

@riverpod
MenstrualTrackingRepository menstrualTrackingRepository(Ref ref) =>
    DriftMenstrualTrackingRepository(ref.watch(appDatabaseProvider));
