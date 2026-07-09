@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSymptomEntryRepository extends Mock
    implements SymptomEntryRepository {}

void main() {
  late MockSymptomEntryRepository repository;

  setUpAll(() {
    registerFallbackValue(SymptomType.migraine);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    repository = MockSymptomEntryRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        symptomEntryRepositoryProvider.overrideWithValue(repository),
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
      ).thenAnswer((_) async {});

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
  });
}
