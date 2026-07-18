import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/notifications/data/notification_preferences_repository.dart';
import 'package:assiette/features/notifications/domain/notification_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_preferences_repository.g.dart';

/// Persistence for the notification settings screen (US-16).
abstract class NotificationPreferencesRepository {
  /// Streams the current notification preferences, falling back to
  /// [NotificationPreferences.defaults] until the user saves for the first
  /// time.
  Stream<NotificationPreferences> watchPreferences();

  /// Persists [preferences].
  Future<void> savePreferences(NotificationPreferences preferences);
}

/// Provides the [NotificationPreferencesRepository] implementation.
@riverpod
NotificationPreferencesRepository notificationPreferencesRepository(
  Ref ref,
) {
  final db = ref.watch(appDatabaseProvider);
  return DriftNotificationPreferencesRepository(
    appSettingsDao: db.appSettingsDao,
  );
}
