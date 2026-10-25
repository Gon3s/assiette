import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

/// App info screen: version, privacy stance, and third-party attributions.
class SettingsScreen extends ConsumerWidget {
  /// Creates a [SettingsScreen].
  const SettingsScreen({super.key});

  static final _privacyPolicyUri = Uri.https(
    'gon3s.github.io',
    '/assiette/privacy.html',
  );

  Future<void> _openPrivacyPolicy(BuildContext context) async {
    var opened = false;
    try {
      opened = await launchUrl(
        _privacyPolicyUri,
        mode: LaunchMode.externalApplication,
      );
    } on Exception {
      // Show localized feedback below when the platform cannot open the URL.
    }
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(AppStrings.of(context).privacyPolicyOpenError),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(s.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.p16),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.label_outline),
            title: Text(s.manageTagsAction),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(AppRouter.tagManagement.name),
          ),
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
            onTap: () => context.pushNamed(AppRouter.notificationSettings.name),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.picture_as_pdf_outlined),
            title: Text(s.exportPdfAction),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(AppRouter.pdfExport.name),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.cloud_outlined),
            title: Text(s.cloudBackupAction),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(AppRouter.cloudBackup.name),
          ),
          gapH16,
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(s.privacyPolicyAction),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _openPrivacyPolicy(context),
          ),
          gapH8,
          Text(s.medicalDisclaimer, style: theme.textTheme.bodySmall),
          gapH16,
          Text(s.aboutSectionTitle, style: theme.textTheme.titleMedium),
          gapH8,
          Text(s.openMeteoAttribution, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
