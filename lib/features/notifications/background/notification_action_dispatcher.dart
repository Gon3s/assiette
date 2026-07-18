import 'dart:async';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/notifications/domain/notification_ids.dart';
import 'package:drift/drift.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Handles a notification action tapped while the app isn't in the
/// foreground: sleep quality and "log the default favorite" actions write
/// straight to Drift without ever showing the UI.
///
/// Runs in its own background isolate with no shared memory: reopen
/// [AppDatabase] directly here, mirroring the pattern used for the US-8
/// background weather capture task.
@pragma('vm:entry-point')
void notificationBackgroundDispatcher(NotificationResponse response) {
  final actionId = response.actionId;
  if (actionId == null) return;

  switch (actionId) {
    case NotificationActionIds.sleepBad:
      unawaited(_logSleepQuality(1));
    case NotificationActionIds.sleepMedium:
      unawaited(_logSleepQuality(2));
    case NotificationActionIds.sleepGood:
      unawaited(_logSleepQuality(3));
    case NotificationActionIds.mealFavorite:
      unawaited(_logDefaultFavorite());
  }
}

Future<void> _logSleepQuality(int quality) async {
  final db = AppDatabase();
  try {
    final now = DateTime.now();
    final nightDate = DateTime(now.year, now.month, now.day).toUtc();
    final existing = await db.sleepEntriesDao.watchByDate(now).first;
    final nowUtc = DateTime.now().toUtc();
    await db.sleepEntriesDao.upsertSleepEntry(
      SleepEntriesCompanion.insert(
        id: existing?.id ?? _uuid.v4(),
        nightDate: nightDate,
        quality: quality,
        createdAt: Value(existing?.createdAt ?? nowUtc),
        updatedAt: Value(nowUtc),
      ),
    );
  } finally {
    await db.close();
  }
}

/// Logs the most recently created favorite, since there is no persisted
/// "default favorite" concept to pick from yet. A silent no-op when the
/// user has no favorites.
Future<void> _logDefaultFavorite() async {
  final db = AppDatabase();
  try {
    final templates = await db.templatesDao.watchAllWithTags().first;
    if (templates.isEmpty) return;

    final defaultTemplate = templates.reduce(
      (a, b) => b.template.createdAt.isAfter(a.template.createdAt) ? b : a,
    );

    final now = DateTime.now().toUtc();
    await db.mealsDao.insertMealWithTags(
      MealsCompanion.insert(
        id: _uuid.v4(),
        timestamp: now,
        mealType: MealType.values.firstWhere(
          (t) => t.name == defaultTemplate.template.defaultMealType,
          orElse: () => defaultMealTypeFor(now.toLocal()),
        ),
        photoPath: Value(defaultTemplate.template.defaultPhotoPath),
        templateId: Value(defaultTemplate.template.id),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
      [for (final tag in defaultTemplate.tags) tag.id],
    );
  } finally {
    await db.close();
  }
}
