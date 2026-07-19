@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/medication_entry/domain/medication_entry_repository.dart';
import 'package:assiette/features/medication_entry/domain/medication_intake_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSymptomEntryRepository extends Mock
    implements SymptomEntryRepository {}

class MockMedicationEntryRepository extends Mock
    implements MedicationEntryRepository {}

void main() {
  late MockSymptomEntryRepository repository;
  late MockMedicationEntryRepository medicationRepository;

  setUpAll(() {
    registerFallbackValue(SymptomType.migraine);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    repository = MockSymptomEntryRepository();
    medicationRepository = MockMedicationEntryRepository();
    when(() => medicationRepository.loadIntakesForSymptom(any()))
        .thenAnswer((_) async => []);
    when(() => medicationRepository.recentNames())
        .thenAnswer((_) async => []);
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        symptomEntryRepositoryProvider.overrideWithValue(repository),
        medicationEntryRepositoryProvider
            .overrideWithValue(medicationRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('SymptomEntryController', () {
    test('initial state defaults to migraine, intensity 5, no detail', () {
      final container = makeContainer();
      final state = container.read(symptomEntryControllerProvider);

      expect(state.type, SymptomType.migraine);
      expect(state.intensity, 5);
      expect(state.detail, isNull);
      expect(state.endTime, isNull);
      expect(state.note, isEmpty);
      expect(state.isSaving, isFalse);
    });

    test('setType changes the type and clears the detail', () {
      final container = makeContainer();
      container.read(symptomEntryControllerProvider.notifier)
        ..setType(SymptomType.digestive)
        ..toggleDetail('ballonnement')
        ..setType(SymptomType.mood);

      final state = container.read(symptomEntryControllerProvider);
      expect(state.type, SymptomType.mood);
      expect(state.detail, isNull);
    });

    test('toggleDetail selects then clears on a second tap', () {
      final container = makeContainer();
      final controller = container.read(
        symptomEntryControllerProvider.notifier,
      )..toggleDetail('douleur');

      expect(
        container.read(symptomEntryControllerProvider).detail,
        'douleur',
      );

      controller.toggleDetail('douleur');
      expect(container.read(symptomEntryControllerProvider).detail, isNull);
    });

    test('setEndTime sets it, clearEndTime resets it', () {
      final container = makeContainer();
      final controller = container.read(
        symptomEntryControllerProvider.notifier,
      )..setEndTime(DateTime(2026, 1, 1, 10));

      expect(
        container.read(symptomEntryControllerProvider).endTime,
        DateTime(2026, 1, 1, 10),
      );

      controller.clearEndTime();
      expect(container.read(symptomEntryControllerProvider).endTime, isNull);
    });

    test('save passes the form to the repository and reports success',
        () async {
      when(
        () => repository.saveSymptom(
          timestamp: any(named: 'timestamp'),
          type: any(named: 'type'),
          intensity: any(named: 'intensity'),
          detail: any(named: 'detail'),
          endTime: any(named: 'endTime'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async => 'symptom-new');

      final container = makeContainer();
      final controller =
          container.read(symptomEntryControllerProvider.notifier)
            ..setType(SymptomType.digestive)
            ..setIntensity(8)
            ..toggleDetail('ballonnement')
            ..setNote('après le déjeuner');

      final saved = await controller.save();

      expect(saved, isTrue);
      expect(
        container.read(symptomEntryControllerProvider).isSaving,
        isFalse,
      );
      verify(
        () => repository.saveSymptom(
          timestamp: any(named: 'timestamp'),
          type: SymptomType.digestive,
          intensity: 8,
          detail: 'ballonnement',
          note: 'après le déjeuner',
        ),
      ).called(1);
    });

    test('save persists new intakes linked to the created symptom', () async {
      when(
        () => repository.saveSymptom(
          timestamp: any(named: 'timestamp'),
          type: any(named: 'type'),
          intensity: any(named: 'intensity'),
          detail: any(named: 'detail'),
          endTime: any(named: 'endTime'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async => 'symptom-new');
      when(
        () => medicationRepository.saveIntake(
          timestamp: any(named: 'timestamp'),
          name: any(named: 'name'),
          dose: any(named: 'dose'),
          symptomId: any(named: 'symptomId'),
        ),
      ).thenAnswer((_) async {});

      final container = makeContainer();
      final controller =
          container.read(symptomEntryControllerProvider.notifier)
            ..addIntake(
              MedicationIntakeDraft(
                timestamp: DateTime(2026, 7, 19, 10),
                name: 'Bi-Profenid',
                dose: '100 mg',
              ),
            );

      final saved = await controller.save();

      expect(saved, isTrue);
      verify(
        () => medicationRepository.saveIntake(
          timestamp: DateTime(2026, 7, 19, 10),
          name: 'Bi-Profenid',
          dose: '100 mg',
          symptomId: 'symptom-new',
        ),
      ).called(1);
    });

    test('removeIntakeAt on a persisted intake soft-deletes it on save',
        () async {
      when(
        () => repository.updateSymptom(
          id: any(named: 'id'),
          timestamp: any(named: 'timestamp'),
          type: any(named: 'type'),
          intensity: any(named: 'intensity'),
          detail: any(named: 'detail'),
          endTime: any(named: 'endTime'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async {});
      when(() => medicationRepository.deleteIntake(any()))
          .thenAnswer((_) async {});
      when(() => medicationRepository.loadIntakesForSymptom('symptom-1'))
          .thenAnswer(
        (_) async => [
          MedicationIntakeDraft(
            id: 'intake-1',
            timestamp: DateTime(2026, 7, 7, 9, 30),
            name: 'Sumatriptan',
            symptomId: 'symptom-1',
          ),
        ],
      );

      final container = makeContainer();
      final controller =
          container.read(symptomEntryControllerProvider.notifier);
      await controller.loadForEdit(
        SymptomDraft(
          id: 'symptom-1',
          timestamp: DateTime(2026, 7, 7, 9),
          type: SymptomType.migraine,
          intensity: 5,
        ),
      );
      expect(
        container.read(symptomEntryControllerProvider).intakes,
        hasLength(1),
      );

      controller.removeIntakeAt(0);
      final saved = await controller.save();

      expect(saved, isTrue);
      verify(() => medicationRepository.deleteIntake('intake-1')).called(1);
      verifyNever(
        () => medicationRepository.saveIntake(
          timestamp: any(named: 'timestamp'),
          name: any(named: 'name'),
          dose: any(named: 'dose'),
          symptomId: any(named: 'symptomId'),
        ),
      );
    });

    test('save resets isSaving and rethrows on failure', () async {
      when(
        () => repository.saveSymptom(
          timestamp: any(named: 'timestamp'),
          type: any(named: 'type'),
          intensity: any(named: 'intensity'),
          detail: any(named: 'detail'),
          endTime: any(named: 'endTime'),
          note: any(named: 'note'),
        ),
      ).thenThrow(StateError('db unavailable'));

      final container = makeContainer();
      final controller = container.read(
        symptomEntryControllerProvider.notifier,
      );

      await expectLater(controller.save(), throwsStateError);
      expect(
        container.read(symptomEntryControllerProvider).isSaving,
        isFalse,
      );
    });

    test('loadForEdit seeds the form from an existing symptom', () async {
      final container = makeContainer();
      await container
          .read(symptomEntryControllerProvider.notifier)
          .loadForEdit(
        SymptomDraft(
          id: 'symptom-1',
          timestamp: DateTime(2026, 7, 7, 9),
          type: SymptomType.digestive,
          intensity: 8,
          detail: 'ballonnement',
          note: 'après le déjeuner',
        ),
      );

      final state = container.read(symptomEntryControllerProvider);
      expect(state.id, 'symptom-1');
      expect(state.type, SymptomType.digestive);
      expect(state.intensity, 8);
      expect(state.detail, 'ballonnement');
      expect(state.note, 'après le déjeuner');
    });

    test('save calls updateSymptom when editing an existing symptom',
        () async {
      when(
        () => repository.updateSymptom(
          id: any(named: 'id'),
          timestamp: any(named: 'timestamp'),
          type: any(named: 'type'),
          intensity: any(named: 'intensity'),
          detail: any(named: 'detail'),
          endTime: any(named: 'endTime'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async {});

      final container = makeContainer();
      final controller =
          container.read(symptomEntryControllerProvider.notifier);
      await controller.loadForEdit(
        SymptomDraft(
          id: 'symptom-1',
          timestamp: DateTime(2026, 7, 7, 9),
          type: SymptomType.migraine,
          intensity: 5,
        ),
      );
      controller.setIntensity(9);

      final saved = await controller.save();

      expect(saved, isTrue);
      verify(
        () => repository.updateSymptom(
          id: 'symptom-1',
          timestamp: any(named: 'timestamp'),
          type: SymptomType.migraine,
          intensity: 9,
          detail: any(named: 'detail'),
          endTime: any(named: 'endTime'),
          note: any(named: 'note'),
        ),
      ).called(1);
      verifyNever(
        () => repository.saveSymptom(
          timestamp: any(named: 'timestamp'),
          type: any(named: 'type'),
          intensity: any(named: 'intensity'),
          detail: any(named: 'detail'),
          endTime: any(named: 'endTime'),
          note: any(named: 'note'),
        ),
      );
    });

    test('delete soft-deletes the symptom being edited', () async {
      when(
        () => repository.deleteSymptom('symptom-1'),
      ).thenAnswer((_) async {});

      final container = makeContainer();
      final controller =
          container.read(symptomEntryControllerProvider.notifier);
      await controller.loadForEdit(
        SymptomDraft(
          id: 'symptom-1',
          timestamp: DateTime(2026, 7, 7, 9),
          type: SymptomType.migraine,
          intensity: 5,
        ),
      );

      final deleted = await controller.delete();

      expect(deleted, isTrue);
      verify(() => repository.deleteSymptom('symptom-1')).called(1);
    });

    test('delete is a no-op when creating a new symptom (no id)', () async {
      final container = makeContainer();
      final deleted = await container
          .read(symptomEntryControllerProvider.notifier)
          .delete();

      expect(deleted, isFalse);
      verifyNever(() => repository.deleteSymptom(any()));
    });
  });
}
