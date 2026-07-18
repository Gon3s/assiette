import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// App info screen: version, privacy stance, and third-party attributions.
class SettingsScreen extends StatelessWidget {
  /// Creates a [SettingsScreen].
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(s.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.p16),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.star_outline),
            title: Text(s.manageFavoritesAction),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(AppRouter.favoritesManage.name),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.notifications_outlined),
            title: Text(s.manageNotificationsAction),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                context.pushNamed(AppRouter.notificationSettings.name),
          ),
          gapH16,
          Text(s.aboutSectionTitle, style: theme.textTheme.titleMedium),
          gapH8,
          Text(s.openMeteoAttribution, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
