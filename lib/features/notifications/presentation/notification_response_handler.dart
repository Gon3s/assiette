import 'dart:async';

import 'package:assiette/features/notifications/domain/notification_ids.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

/// Handles a notification action tapped while the app has a live UI (or one
/// that just relaunched it because [rootNavigatorKey] is already attached).
///
/// Only the meal reminder's "Photo" action reaches here: every other action
/// (sleep quality, "log the default favorite") sets
/// `showsUserInterface: false` and is handled fully in the background by
/// `notificationBackgroundDispatcher`, without ever calling this.
///
/// On a cold start, [rootNavigatorKey] may not be attached yet when this
/// fires; the tap is then silently dropped and the app opens on the home
/// screen instead of the meal entry form.
void handleForegroundNotificationResponse(NotificationResponse response) {
  if (response.actionId != NotificationActionIds.mealPhoto) return;

  final context = rootNavigatorKey.currentContext;
  if (context == null) return;
  unawaited(GoRouter.of(context).pushNamed(AppRouter.mealEntry.name));
}
