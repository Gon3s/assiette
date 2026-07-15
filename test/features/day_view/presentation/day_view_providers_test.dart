@Timeout(Duration(seconds: 5))
library;

import 'dart:async';

import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDayViewRepository extends Mock implements DayViewRepository {}

void main() {
  late MockDayViewRepository repository;

  setUp(() {
    repository = MockDayViewRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        dayViewRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('dayTimelineProvider', () {
    test('goes from loading to data with the repository stream', () async {
      final item = TimelineItem.symptom(
        id: 'symptom-1',
        timestamp: DateTime.utc(2026, 7, 6, 9),
        symptomType: SymptomType.migraine,
        intensity: 7,
      );
      when(() => repository.watchTimeline(any()))
          .thenAnswer((_) => Stream.value([item]));

      final container = makeContainer();
      final states = <AsyncValue<List<TimelineItem>>>[];
      container.listen(
        dayTimelineProvider,
        (_, next) => states.add(next),
        fireImmediately: true,
      );

      expect(states.single, isA<AsyncLoading<List<TimelineItem>>>());
      await container.read(dayTimelineProvider.future);
      expect(states.last.requireValue, [item]);
    });

    test('exposes stream errors as AsyncError', () async {
      when(() => repository.watchTimeline(any()))
          .thenAnswer((_) => Stream.error(StateError('db unavailable')));

      final container = makeContainer()
        ..listen(dayTimelineProvider, (_, _) {});

      await expectLater(
        container.read(dayTimelineProvider.future),
        throwsStateError,
      );
      expect(container.read(dayTimelineProvider).hasError, isTrue);
    });

    test('re-emits when the repository stream emits again', () async {
      final controller = StreamController<List<TimelineItem>>();
      addTearDown(controller.close);
      when(() => repository.watchTimeline(any()))
          .thenAnswer((_) => controller.stream);

      final container = makeContainer()
        ..listen(dayTimelineProvider, (_, _) {});

      controller.add([]);
      await container.read(dayTimelineProvider.future);
      expect(container.read(dayTimelineProvider).requireValue, isEmpty);

      final item = TimelineItem.symptom(
        id: 'symptom-1',
        timestamp: DateTime.utc(2026, 7, 6, 9),
        symptomType: SymptomType.mood,
        intensity: 3,
      );
      controller.add([item]);
      await pumpEventQueue();
      expect(container.read(dayTimelineProvider).requireValue, [item]);
    });
  });
}
