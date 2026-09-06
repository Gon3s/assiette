@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_entry_repository.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDayViewRepository extends Mock implements DayViewRepository {}

class MockSleepEntryRepository extends Mock implements SleepEntryRepository {}

void main() {
  late MockDayViewRepository dayViewRepository;
  late MockSleepEntryRepository sleepEntryRepository;

  setUpAll(() {
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    dayViewRepository = MockDayViewRepository();
    sleepEntryRepository = MockSleepEntryRepository();
    when(
      () => dayViewRepository.watchSleepForNight(any()),
    ).thenAnswer((_) => Stream.value(null));
  });

  Future<ProviderContainer> makeContainer() async {
    final container = ProviderContainer(
      overrides: [
        dayViewRepositoryProvider.overrideWithValue(dayViewRepository),
        sleepEntryRepositoryProvider.overrideWithValue(sleepEntryRepository),
      ],
    );
    addTearDown(container.dispose);
    // Keep daySleepProvider alive (it's auto-dispose) and resolve it before
    // the controller reads it, mirroring the real navigation path where the
    // card already shows the resolved sleep.
    final day = container.read(selectedDateProvider);
    container.listen(daySleepProvider(day), (_, _) {});
    await container.read(daySleepProvider(day).future);
    return container;
  }

  group('SleepEntryController', () {
    test(
      'initial state defaults to quality 2 when no sleep is logged',
      () async {
        final container = await makeContainer();
        final state = container.read(sleepEntryControllerProvider);

        expect(state.quality, 2);
        expect(state.bedTime, isNull);
        expect(state.wakeTime, isNull);
        expect(state.isSaving, isFalse);
      },
    );

    test('initial state is seeded from the logged sleep', () async {
      when(() => dayViewRepository.watchSleepForNight(any())).thenAnswer(
        (_) => Stream.value(
          SleepSummary(
            quality: 3,
            bedTime: DateTime(2026, 7, 7, 23),
            wakeTime: DateTime(2026, 7, 8, 7),
          ),
        ),
      );

      final container = await makeContainer();
      final state = container.read(sleepEntryControllerProvider);

      expect(state.quality, 3);
      expect(state.bedTime, DateTime(2026, 7, 7, 23));
      expect(state.wakeTime, DateTime(2026, 7, 8, 7));
    });

    test('setQuality changes the quality', () async {
      final container = await makeContainer();
      container.read(sleepEntryControllerProvider.notifier).setQuality(1);

      expect(container.read(sleepEntryControllerProvider).quality, 1);
    });

    test('setBedTime sets it, clearBedTime resets it', () async {
      final container = await makeContainer();
      final controller = container.read(sleepEntryControllerProvider.notifier)
        ..setBedTime(DateTime(2026, 1, 1, 23));

      expect(
        container.read(sleepEntryControllerProvider).bedTime,
        DateTime(2026, 1, 1, 23),
      );

      controller.clearBedTime();
      expect(container.read(sleepEntryControllerProvider).bedTime, isNull);
    });

    test('setWakeTime sets it, clearWakeTime resets it', () async {
      final container = await makeContainer();
      final controller = container.read(sleepEntryControllerProvider.notifier)
        ..setWakeTime(DateTime(2026, 1, 1, 7));

      expect(
        container.read(sleepEntryControllerProvider).wakeTime,
        DateTime(2026, 1, 1, 7),
      );

      controller.clearWakeTime();
      expect(container.read(sleepEntryControllerProvider).wakeTime, isNull);
    });

    test(
      'save passes the form to the repository and reports success',
      () async {
        when(
          () => sleepEntryRepository.saveSleepEntry(
            day: any(named: 'day'),
            quality: any(named: 'quality'),
            bedTime: any(named: 'bedTime'),
            wakeTime: any(named: 'wakeTime'),
          ),
        ).thenAnswer((_) async {});

        final container = await makeContainer();
        final controller = container.read(sleepEntryControllerProvider.notifier)
          ..setQuality(3)
          ..setBedTime(DateTime(2026, 1, 1, 23));

        final saved = await controller.save();

        expect(saved, isTrue);
        expect(container.read(sleepEntryControllerProvider).isSaving, isFalse);
        verify(
          () => sleepEntryRepository.saveSleepEntry(
            day: any(named: 'day'),
            quality: 3,
            bedTime: DateTime(2026, 1, 1, 23),
          ),
        ).called(1);
      },
    );

    test('save resets isSaving and rethrows on failure', () async {
      when(
        () => sleepEntryRepository.saveSleepEntry(
          day: any(named: 'day'),
          quality: any(named: 'quality'),
          bedTime: any(named: 'bedTime'),
          wakeTime: any(named: 'wakeTime'),
        ),
      ).thenThrow(StateError('db unavailable'));

      final container = await makeContainer();
      final controller = container.read(
        sleepEntryControllerProvider.notifier,
      );

      await expectLater(controller.save(), throwsStateError);
      expect(container.read(sleepEntryControllerProvider).isSaving, isFalse);
    });

    test('delete soft-deletes the logged night', () async {
      when(() => dayViewRepository.watchSleepForNight(any())).thenAnswer(
        (_) => Stream.value(const SleepSummary(id: 'sleep-1', quality: 3)),
      );
      when(
        () => dayViewRepository.deleteSleepEntry('sleep-1'),
      ).thenAnswer((_) async {});

      final container = await makeContainer();
      final deleted = await container
          .read(sleepEntryControllerProvider.notifier)
          .delete();

      expect(deleted, isTrue);
      verify(() => dayViewRepository.deleteSleepEntry('sleep-1')).called(1);
    });

    test('delete is a no-op when nothing is logged (no id)', () async {
      final container = await makeContainer();
      final deleted = await container
          .read(sleepEntryControllerProvider.notifier)
          .delete();

      expect(deleted, isFalse);
      verifyNever(() => dayViewRepository.deleteSleepEntry(any()));
    });
  });
}
