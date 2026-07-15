import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/symptom_entry/data/symptom_entry_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'symptom_entry_repository.g.dart';

/// Persistence for the symptom entry form. A single-method contract by
/// design, kept as a class to match this project's repository convention.
// ignore: one_member_abstracts
abstract class SymptomEntryRepository {
  /// Inserts the symptom entry.
  Future<void> saveSymptom({
    required DateTime timestamp,
    required SymptomType type,
    required int intensity,
    String? detail,
    DateTime? endTime,
    String? note,
  });
}

/// Provides the [SymptomEntryRepository] implementation.
@riverpod
SymptomEntryRepository symptomEntryRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftSymptomEntryRepository(db: db);
}
