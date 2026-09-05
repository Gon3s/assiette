@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/medication_entry/domain/medication_entry_repository.dart';
import 'package:assiette/features/medication_entry/domain/medication_intake_draft.dart';
import 'package:assiette/features/symptom_entry/domain/migraine_observation.dart';
import 'package:assiette/features/symptom_entry/domain/migraine_observation_repository.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pump(
    WidgetTester tester, {
    SymptomType type = SymptomType.migraine,
    SymptomDraft? draft,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          symptomEntryRepositoryProvider.overrideWithValue(
            _FakeSymptomRepository(),
          ),
          migraineObservationRepositoryProvider.overrideWithValue(
            _FakeMigraineObservationRepository(),
          ),
          medicationEntryRepositoryProvider.overrideWithValue(
            _FakeMedicationRepository(),
          ),
        ],
        child: MaterialApp(
          home: SymptomEntryScreen(
            initialType: type,
            initialDate: DateTime(2026, 9, 3),
            draft: draft,
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('migraine uses intensity 0 through 10 and no end field', (
    tester,
  ) async {
    await pump(tester);

    expect(find.text('New migraine'), findsOneWidget);
    for (var value = 0; value <= 10; value++) {
      expect(find.text('$value'), findsOneWidget);
    }
    expect(find.text('Add an end time'), findsNothing);
    expect(find.text('Dose (optional)'), findsNothing);
  });

  testWidgets('existing migraine exposes end and maximum intensity', (
    tester,
  ) async {
    await pump(
      tester,
      draft: SymptomDraft(
        id: 'migraine',
        timestamp: DateTime(2026, 9, 3, 9),
        type: SymptomType.migraine,
        startedAt: DateTime(2026, 9, 3, 9),
        startPrecision: MigraineStartPrecision.exact,
        endedAt: DateTime(2026, 9, 3, 12, 45),
        initialIntensity: 4,
        maximumIntensity: 8,
      ),
    );

    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();

    expect(find.text('End'), findsOneWidget);
    expect(find.text('Maximum intensity'), findsOneWidget);
    expect(find.text('Migraine evolution'), findsOneWidget);
    expect(find.text('Add an observation'), findsOneWidget);
    expect(find.text('12:45'), findsOneWidget);
    final maximumChip = tester.widget<ChoiceChip>(
      find
          .ancestor(
            of: find.text('8'),
            matching: find.byType(ChoiceChip),
          )
          .last,
    );
    expect(maximumChip.selected, isTrue);
  });

  testWidgets('physical feeling has categories without intensity or time', (
    tester,
  ) async {
    await pump(tester, type: SymptomType.digestive);

    expect(find.text('Feeling'), findsOneWidget);
    expect(find.text('Digestive'), findsOneWidget);
    expect(find.text('Pain'), findsOneWidget);
    expect(find.text('Eczema'), findsOneWidget);
    expect(find.text('Intensity'), findsNothing);
    expect(find.byIcon(Icons.schedule), findsNothing);
  });

  testWidgets('mood is a single untimed free-text form', (tester) async {
    await pump(tester, type: SymptomType.mood);

    expect(find.text('Mood of the day'), findsOneWidget);
    expect(find.text('What are you feeling?'), findsOneWidget);
    expect(find.text('Category'), findsNothing);
    expect(find.byIcon(Icons.schedule), findsNothing);
  });

  testWidgets('legacy daily entry shows historical intensity as read-only', (
    tester,
  ) async {
    await pump(
      tester,
      draft: SymptomDraft(
        id: 'legacy',
        timestamp: DateTime(2026, 9, 3, 8),
        type: SymptomType.pain,
        intensity: 7,
        note: 'dos',
      ),
    );

    expect(find.text('Previously recorded intensity: 7/10'), findsOneWidget);
    expect(find.text('dos'), findsOneWidget);
  });
}

class _FakeMigraineObservationRepository
    implements MigraineObservationRepository {
  @override
  Future<String> addObservation(
    String migraineId,
    MigraineObservationInput input,
  ) async => 'observation';

  @override
  Future<void> deleteObservation(String id) async {}

  @override
  Future<void> undoDeleteObservation(String id) async {}

  @override
  Future<void> updateObservation(
    String id,
    MigraineObservationInput input,
  ) async {}

  @override
  Stream<List<MigraineObservation>> watchObservations(String migraineId) =>
      Stream.value(const []);
}

class _FakeSymptomRepository implements SymptomEntryRepository {
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
  }) async => 'new-id';

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
  }) async {}

  @override
  Future<void> deleteSymptom(String id) async {}

  @override
  Future<SymptomDraft?> loadDailyMood(DateTime day) async => null;

  @override
  Future<SymptomDraft?> loadSymptom(String id) async => null;

  @override
  Future<void> undoDeleteSymptom(String id) async {}
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
