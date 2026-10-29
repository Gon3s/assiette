import 'package:assiette/features/menstrual_tracking/presentation/menstrual_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenstrualExportNotice extends ConsumerWidget {
  const MenstrualExportNotice({required this.forBackup, super.key});

  final bool forBackup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final preferences = ref.watch(menstrualPreferencesProvider);
    return preferences.when(
      loading: () => const LinearProgressIndicator(),
      error: (_, _) => TextButton(
        onPressed: () => ref.invalidate(menstrualPreferencesProvider),
        child: Text(s.retryAction),
      ),
      data: (value) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.water_drop_outlined),
        title: Text(
          forBackup
              ? value.includeInBackup
                    ? s.menstrualBackupIncluded
                    : s.menstrualBackupExcluded
              : value.includeInPdf
              ? s.menstrualPdfIncluded
              : s.menstrualPdfExcluded,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.pushNamed(AppRouter.menstrualSettings.name),
      ),
    );
  }
}
