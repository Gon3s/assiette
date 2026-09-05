@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/medication_entry/domain/medication_entry_repository.dart';
import 'package:assiette/features/medication_entry/domain/medication_intake_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakeSymptomRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _FakeSymptomRepository();
    container = ProviderContainer(
      overrides: [
        symptomEntryRepositoryProvider.overrideWithValue(repository),
        medicationEntryRepositoryProvider.overrideWithValue(
          _FakeMedicationRepository(),
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('starts with a migraine intensity between 0 and 10', () {
    final state = container.read(symptomEntryControllerProvider);
    expect(state.type, SymptomType.migraine);
    expect(state.intensity, 5);
  });

  test('daily mood saves a day key without intensity', () async {
    final controller =
        container.read(
            symptomEntryControllerProvider.notifier,
          )
          ..initialize(SymptomType.mood, DateTime(2026, 9, 3))
          ..setNote('calme');

    expect(await controller.save(), isTrue);
    expect(repository.savedType, SymptomType.mood);
    expect(repository.savedIntensity, isNull);
    expect(repository.savedDailyDate, DateTime(2026, 9, 3));
    expect(repository.savedIsDailyNote, isTrue);
  });

  test('migraine saves its precision and initial measurement', () async {
    final controller =
        container.read(
            symptomEntryControllerProvider.notifier,
          )
          ..initialize(SymptomType.migraine, DateTime(2026, 9, 3))
          ..setIntensity(8)
          ..setStartPrecision(MigraineStartPrecision.approximate);

    await controller.save();

    expect(repository.savedIntensity, 8);
    expect(repository.savedInitialIntensity, 8);
    expect(
      repository.savedStartPrecision,
      MigraineStartPrecision.approximate,
    );
    expect(repository.savedIsDailyNote, isFalse);
  });

  test('existing migraine restores and saves completion fields', () async {
    final endedAt = DateTime(2026, 9, 3, 18, 30);
    final controller = container.read(
      symptomEntryControllerProvider.notifier,
    );
    await controller.loadForEdit(
      SymptomDraft(
        id: 'migraine',
        timestamp: DateTime(2026, 9, 3, 14),
        type: SymptomType.migraine,
        intensity: 7,
        startedAt: DateTime(2026, 9, 3, 13, 45),
        startPrecision: MigraineStartPrecision.exact,
        endedAt: endedAt,
        initialIntensity: 4,
        maximumIntensity: 8,
      ),
    );

    final state = container.read(symptomEntryControllerProvider);
    expect(state.timestamp, DateTime(2026, 9, 3, 14));
    expect(state.intensity, 4);
    expect(state.endTime, endedAt);
    expect(state.maximumIntensity, 8);

    expect(await controller.save(), isTrue);
    expect(repository.updatedEndTime, endedAt);
    expect(repository.updatedMaximumIntensity, 8);
  });

  test('raising initial intensity keeps maximum intensity valid', () async {
    final controller = container.read(
      symptomEntryControllerProvider.notifier,
    );
    await controller.loadForEdit(
      SymptomDraft(
        id: 'migraine',
        timestamp: DateTime(2026, 9, 3, 14),
        type: SymptomType.migraine,
        initialIntensity: 4,
        maximumIntensity: 6,
      ),
    );

    controller.setIntensity(8);

    final state = container.read(symptomEntryControllerProvider);
    expect(state.intensity, 8);
    expect(state.maximumIntensity, 8);
  });

  test('legacy daily edit exposes its previous intensity', () async {
    await container
        .read(symptomEntryControllerProvider.notifier)
        .loadForEdit(
          SymptomDraft(
            id: 'legacy',
            timestamp: DateTime(2026, 9, 3, 10),
            type: SymptomType.pain,
            intensity: 6,
          ),
        );

    expect(
      container.read(symptomEntryControllerProvider).previousIntensity,
      6,
    );
  });
}

class _FakeSymptomRepository implements SymptomEntryRepository {
  SymptomType? savedType;
  int? savedIntensity;
  DateTime? savedDailyDate;
  bool? savedIsDailyNote;
  int? savedInitialIntensity;
  MigraineStartPrecision? savedStartPrecision;
  DateTime? updatedEndTime;
  int? updatedMaximumIntensity;

  @override
  Future<String> saveSymptom({
    required DateTime timestamp,
    required SymptomType type,
    int? intensity,
    String? detail,
    DateTime? endTime,
    DateTime? startedAt,
    MigraineStartPrecision? startPrecision,
    DateTime? endedAt,
    int? initialIntensity,
    int? maximumIntensity,
    String? note,
    DateTime? dailyDate,
    bool isDailyNote = false,
  }) async {
    savedType = type;
    savedIntensity = intensity;
    savedDailyDate = dailyDate;
    savedIsDailyNote = isDailyNote;
    savedInitialIntensity = initialIntensity;
    savedStartPrecision = startPrecision;
    return 'new-id';
  }

  @override
  Future<void> updateSymptom({
    required String id,
    required DateTime timestamp,
    required SymptomType type,
    int? intensity,
    String? detail,
    DateTime? endTime,
    DateTime? startedAt,
    MigraineStartPrecision? startPrecision,
    DateTime? endedAt,
    int? initialIntensity,
    int? maximumIntensity,
    String? note,
    DateTime? dailyDate,
    bool isDailyNote = false,
  }) async {
    updatedEndTime = endTime;
    updatedMaximumIntensity = maximumIntensity;
  }

  @override
  Future<void> deleteSymptom(String id) async {}

  @override
  Future<void> undoDeleteSymptom(String id) async {}

  @override
  Future<SymptomDraft?> loadDailyMood(DateTime day) async => null;

  @override
  Future<SymptomDraft?> loadSymptom(String id) async => null;
}

class _FakeMedicationRepository implements MedicationEntryRepository {
  @override
  Future<void> deleteIntake(String id) async {}

  @override
  Future<void> detachFromMigraine(String id) async {}

  @override
  Future<List<MedicationIntakeDraft>> loadIntakesForSymptom(
    String symptomId,
  ) async => const [];

  @override
  Future<List<String>> recentNames() async => const [];

  @override
  Future<String> saveIntake({
    required DateTime timestamp,
    required String name,
    String? dose,
    String? symptomId,
    String? note,
  }) async => 'intake';

  @override
  Future<void> undoDeleteIntake(String id) async {}
}
