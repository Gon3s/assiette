@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/features/notification_settings/presentation/notification_settings_controller.dart';
import 'package:assiette/features/notifications/data/notifications_service.dart';
import 'package:assiette/features/notifications/domain/notification_preferences.dart';
import 'package:assiette/features/notifications/domain/notification_preferences_repository.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationPreferencesRepository extends Mock
    implements NotificationPreferencesRepository {}

class _FakeNotificationsService implements NotificationsService {
  AppStrings? lastStrings;
  NotificationPreferences? lastPreferences;

  @override
  Future<void> init({
    required AppStrings strings,
    DidReceiveNotificationResponseCallback? onForegroundResponse,
  }) async {}

  @override
  Future<void> scheduleDailyReminders(
    AppStrings strings,
    NotificationPreferences preferences,
  ) async {
    lastStrings = strings;
    lastPreferences = preferences;
  }

  @override
  Future<void> requestPermission() async {}

  @override
  Future<void> showPressureDropAlert(AppStrings strings) async {}
}

void main() {
  late MockNotificationPreferencesRepository repository;
  late _FakeNotificationsService notificationsService;
  final strings = AppStrings.ofLocale(const Locale('en'));

  setUpAll(() {
    registerFallbackValue(NotificationPreferences.defaults());
  });

  setUp(() {
    repository = MockNotificationPreferencesRepository();
    notificationsService = _FakeNotificationsService();
    when(() => repository.watchPreferences())
        .thenAnswer((_) => Stream.value(NotificationPreferences.defaults()));
    when(() => repository.savePreferences(any())).thenAnswer((_) async {});
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        notificationPreferencesRepositoryProvider.overrideWithValue(
          repository,
        ),
        notificationsServiceProvider.overrideWithValue(notificationsService),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('NotificationSettingsController', () {
    test('initial state is seeded from the repository', () async {
      final container = makeContainer();

      final preferences = await container.read(
        notificationSettingsControllerProvider.future,
      );

      expect(preferences, NotificationPreferences.defaults());
    });

    test('setMealsEnabled updates the draft without persisting', () async {
      final container = makeContainer();
      await container.read(notificationSettingsControllerProvider.future);

      container
          .read(notificationSettingsControllerProvider.notifier)
          .setMealsEnabled(enabled: false);

      expect(
        container.read(notificationSettingsControllerProvider).value?.mealsEnabled,
        isFalse,
      );
      verifyNever(() => repository.savePreferences(any()));
    });

    test('setBreakfastTime updates only the breakfast time', () async {
      final container = makeContainer();
      await container.read(notificationSettingsControllerProvider.future);

      container
          .read(notificationSettingsControllerProvider.notifier)
          .setBreakfastTime(hour: 7, minute: 15);

      final draft = container.read(notificationSettingsControllerProvider).value!;
      expect(draft.breakfastHour, 7);
      expect(draft.breakfastMinute, 15);
      expect(draft.lunchHour, NotificationPreferences.defaults().lunchHour);
    });

    test('save persists the draft and reschedules notifications', () async {
      final container = makeContainer();
      await container.read(notificationSettingsControllerProvider.future);
      container
          .read(notificationSettingsControllerProvider.notifier)
          .setSymptomsEnabled(enabled: true);

      final saved = await container
          .read(notificationSettingsControllerProvider.notifier)
          .save(strings);

      expect(saved, isTrue);
      verify(
        () => repository.savePreferences(
          any(that: isA<NotificationPreferences>()
              .having((p) => p.symptomsEnabled, 'symptomsEnabled', isTrue)),
        ),
      ).called(1);
      expect(notificationsService.lastPreferences?.symptomsEnabled, isTrue);
    });

    test('save reports failure and keeps the previous value on error',
        () async {
      when(() => repository.savePreferences(any()))
          .thenThrow(StateError('db unavailable'));
      final container = makeContainer();
      await container.read(notificationSettingsControllerProvider.future);

      final saved = await container
          .read(notificationSettingsControllerProvider.notifier)
          .save(strings);

      expect(saved, isFalse);
      expect(
        container.read(notificationSettingsControllerProvider).hasError,
        isTrue,
      );
    });
  });
}
