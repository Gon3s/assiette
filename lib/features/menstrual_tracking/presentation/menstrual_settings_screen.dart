import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/menstrual_tracking/presentation/menstrual_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<bool> confirmMenstrualAction(
  BuildContext context, {
  required String title,
  required String body,
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppStrings.of(context).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppStrings.of(context).confirm),
          ),
        ],
      ),
    ) ??
    false;

class MenstrualSettingsScreen extends ConsumerWidget {
  const MenstrualSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final preferences = ref.watch(menstrualPreferencesProvider);
    final actions = ref.watch(menstrualActionsProvider);
    final notifier = ref.read(menstrualActionsProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text(s.menstrualSettingsTitle)),
      body: preferences.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: TextButton(
            onPressed: () => ref.invalidate(menstrualPreferencesProvider),
            child: Text(s.retryAction),
          ),
        ),
        data: (value) => ListView(
          padding: const EdgeInsets.all(Sizes.p16),
          children: [
            Text(s.menstrualPrivacyNotice),
            gapH16,
            SwitchListTile(
              title: Text(s.menstrualSettingsTitle),
              value: value.enabled,
              onChanged: actions.isLoading
                  ? null
                  : (enabled) => notifier.setPreferences(
                      value.copyWith(enabled: enabled),
                    ),
            ),
            SwitchListTile(
              title: Text(s.menstrualBackupOption),
              value: value.includeInBackup,
              onChanged: actions.isLoading
                  ? null
                  : (enabled) => notifier.setPreferences(
                      value.copyWith(includeInBackup: enabled),
                    ),
            ),
            SwitchListTile(
              title: Text(s.menstrualPdfOption),
              value: value.includeInPdf,
              onChanged: actions.isLoading
                  ? null
                  : (enabled) => notifier.setPreferences(
                      value.copyWith(includeInPdf: enabled),
                    ),
            ),
            gapH16,
            OutlinedButton.icon(
              icon: const Icon(Icons.delete_forever_outlined),
              label: Text(s.menstrualPurgeAction),
              onPressed: actions.isLoading
                  ? null
                  : () async {
                      final confirmed = await confirmMenstrualAction(
                        context,
                        title: s.menstrualPurgeAction,
                        body: s.menstrualPurgeBody,
                      );
                      if (confirmed) await notifier.purge();
                    },
            ),
            if (actions.hasError) Text(s.errorGeneric),
          ],
        ),
      ),
    );
  }
}
