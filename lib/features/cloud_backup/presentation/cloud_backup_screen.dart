import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_state_providers.dart';
import 'package:assiette/features/cloud_backup/presentation/cloud_backup_controller.dart';
import 'package:assiette/features/cloud_backup/presentation/cloud_backup_state.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Google Drive backup/restore screen (US-26): connect, back up now,
/// restore, and see when the last backup ran.
class CloudBackupScreen extends ConsumerWidget {
  /// Creates a [CloudBackupScreen].
  const CloudBackupScreen({super.key});

  Future<void> _signIn(BuildContext context, WidgetRef ref, AppStrings s) async {
    final messenger = ScaffoldMessenger.of(context);
    final error = await ref.read(cloudBackupControllerProvider.notifier).signIn();
    if (error != null) {
      // TODO(US-26): revert to s.errorGeneric once the internal-testing
      // sign-in failure is diagnosed — this surfaces the raw diagnostic
      // message so it shows up in a bug report/screenshot.
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error)));
    }
  }

  Future<void> _backupNow(
    BuildContext context,
    WidgetRef ref,
    AppStrings s,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final ok = await ref.read(cloudBackupControllerProvider.notifier).backupNow();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(ok ? s.cloudBackupSuccess : s.cloudBackupFailure),
        ),
      );
  }

  Future<void> _restore(BuildContext context, WidgetRef ref, AppStrings s) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.cloudRestoreConfirmTitle),
        content: Text(s.cloudRestoreConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(s.cloudRestoreAction),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final outcome = await ref
        .read(cloudBackupControllerProvider.notifier)
        .restoreLatest();
    final message = switch (outcome) {
      RestoreOutcome.success => s.cloudRestoreSuccess,
      RestoreOutcome.notFound => s.cloudRestoreNoBackupFound,
      RestoreOutcome.failure => s.cloudRestoreFailure,
    };
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final controllerState = ref.watch(cloudBackupControllerProvider);
    final lastBackupAt = ref.watch(lastBackupAtProvider);

    return Scaffold(
      appBar: AppBar(title: Text(s.cloudBackupScreenTitle)),
      body: controllerState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        // TODO(US-26): revert to s.errorGeneric once the repeated silent
        // sign-in failure is diagnosed.
        error: (error, stack) => Center(child: Text('$error')),
        data: (state) => ListView(
          padding: const EdgeInsets.all(Sizes.p16),
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.account_circle_outlined),
              title: Text(
                state.signedInEmail != null
                    ? s.cloudBackupSignedInAs(state.signedInEmail!)
                    : s.cloudBackupNotSignedIn,
              ),
              trailing: state.isBusy
                  ? const SizedBox(
                      height: Sizes.p20,
                      width: Sizes.p20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
            ),
            gapH16,
            if (state.signedInEmail == null)
              FilledButton.icon(
                onPressed: state.isBusy ? null : () => _signIn(context, ref, s),
                icon: const Icon(Icons.login),
                label: Text(s.cloudBackupSignInAction),
              )
            else ...[
              OutlinedButton.icon(
                onPressed: state.isBusy
                    ? null
                    : () => ref.read(cloudBackupControllerProvider.notifier).signOut(),
                icon: const Icon(Icons.logout),
                label: Text(s.cloudBackupSignOutAction),
              ),
              gapH16,
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.history),
                title: Text(s.cloudBackupLastBackupLabel),
                subtitle: Text(
                  lastBackupAt.when(
                    data: (timestamp) => timestamp == null
                        ? s.cloudBackupNeverBackedUp
                        : DateFormat.yMd(locale).add_Hm().format(
                              timestamp.toLocal(),
                            ),
                    loading: () => '',
                    error: (error, stack) => s.cloudBackupNeverBackedUp,
                  ),
                ),
              ),
              gapH16,
              FilledButton.icon(
                onPressed: state.isBusy
                    ? null
                    : () => _backupNow(context, ref, s),
                icon: const Icon(Icons.cloud_upload_outlined),
                label: Text(s.cloudBackupNowAction),
              ),
              gapH8,
              OutlinedButton.icon(
                onPressed: state.isBusy ? null : () => _restore(context, ref, s),
                icon: const Icon(Icons.cloud_download_outlined),
                label: Text(s.cloudRestoreAction),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
