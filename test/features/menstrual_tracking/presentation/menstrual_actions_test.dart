import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_tracking_repository.dart';
import 'package:assiette/features/menstrual_tracking/presentation/menstrual_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMenstrualRepository extends Mock
    implements MenstrualTrackingRepository {}

void main() {
  test(
    'controller exposes loading and error then supports a successful retry',
    () async {
      final repository = MockMenstrualRepository();
      const observation = MenstrualObservation(
        localDate: '2026-10-01',
        status: BleedingStatus.none,
      );
      when(() => repository.save(observation)).thenThrow(StateError('failed'));
      final container = ProviderContainer(
        overrides: [
          menstrualTrackingRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
      final states = <AsyncValue<void>>[];
      container.listen(menstrualActionsProvider, (_, next) => states.add(next));
      await container.read(menstrualActionsProvider.future);
      final controller = container.read(menstrualActionsProvider.notifier);
      expect(await controller.save(observation), isFalse);
      expect(states.any((state) => state.isLoading), isTrue);
      expect(container.read(menstrualActionsProvider).hasError, isTrue);
      when(() => repository.save(observation)).thenAnswer((_) async {});
      expect(await controller.save(observation), isTrue);
      expect(container.read(menstrualActionsProvider).hasError, isFalse);
    },
  );
}
