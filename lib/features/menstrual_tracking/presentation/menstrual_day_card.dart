import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:assiette/features/menstrual_tracking/presentation/menstrual_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/menstrual_labels.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenstrualDayCard extends ConsumerWidget {
  const MenstrualDayCard({required this.date, super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(menstrualPreferencesProvider);
    if (preferences.value?.enabled != true) return const SizedBox.shrink();
    final key = menstrualDateKey(date);
    if (key.compareTo(menstrualDateKey(DateTime.now())) > 0) {
      return const SizedBox.shrink();
    }
    final observation = ref.watch(menstrualDayProvider(key));
    final s = AppStrings.of(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.water_drop_outlined),
        title: Text(s.menstrualTitle),
        subtitle: observation.when(
          data: (value) => Text(
            [
              if (value == null)
                s.menstrualUnknown
              else
                menstrualSummary(s, value),
              if (value?.note != null) value!.note!,
            ].join('\n'),
          ),
          error: (_, _) => Text(s.errorGeneric),
          loading: () => const LinearProgressIndicator(),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () =>
            context.pushNamed(AppRouter.menstrualEntry.name, extra: date),
      ),
    );
  }
}
