import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/notifications/data/notification_preferences_repository.dart';
import 'package:assiette/features/notifications/domain/notification_preferences.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftNotificationPreferencesRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftNotificationPreferencesRepository(
      appSettingsDao: db.appSettingsDao,
    );
  });

  tearDown(() => db.close());

  group('DriftNotificationPreferencesRepository', () {
    test('watchPreferences emits defaults when nothing is saved yet',
        () async {
      final preferences = await repository.watchPreferences().first;

      expect(preferences, NotificationPreferences.defaults());
    });

    test('savePreferences persists and watchPreferences reflects it',
        () async {
      const preferences = NotificationPreferences(
        mealsEnabled: false,
        breakfastHour: 7,
        breakfastMinute: 15,
        lunchHour: 13,
        lunchMinute: 0,
        dinnerHour: 20,
        dinnerMinute: 0,
        sleepEnabled: false,
        sleepHour: 9,
        sleepMinute: 30,
        weatherEnabled: false,
        symptomsEnabled: true,
        symptomsHour: 21,
        symptomsMinute: 45,
      );

      await repository.savePreferences(preferences);
      final reloaded = await repository.watchPreferences().first;

      expect(reloaded, preferences);
    });

    test('symptoms reminders default to off', () async {
      final preferences = await repository.watchPreferences().first;

      expect(preferences.symptomsEnabled, isFalse);
    });
  });
}
