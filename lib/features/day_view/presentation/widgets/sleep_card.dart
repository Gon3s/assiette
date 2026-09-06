import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Card showing the sleep quality logged for the selected day's night.
///
/// When the night isn't logged yet, offers 1-tap buttons to log it
/// directly. Once logged, tapping the card opens the detail screen to
/// edit the quality and the optional bed/wake time.
class SleepCard extends ConsumerWidget {
  /// Creates a [SleepCard].
  const SleepCard({required this.date, super.key});

  /// Day whose night is displayed and edited.
  final DateTime date;

  Future<void> _logQuality(
    BuildContext context,
    WidgetRef ref,
    int quality,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final s = AppStrings.of(context);
    try {
      await ref.read(dayViewRepositoryProvider).logSleepQuality(date, quality);
    } on Exception {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final sleep = ref.watch(daySleepProvider(date)).value;

    if (sleep == null) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.sleepQuestion,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              gapH8,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _logQuality(context, ref, 1),
                      icon: const Icon(Icons.sentiment_dissatisfied),
                      label: Text(s.sleepQualityBad),
                    ),
                  ),
                  gapW8,
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _logQuality(context, ref, 2),
                      icon: const Icon(Icons.sentiment_neutral),
                      label: Text(s.sleepQualityMedium),
                    ),
                  ),
                  gapW8,
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _logQuality(context, ref, 3),
                      icon: const Icon(Icons.sentiment_satisfied),
                      label: Text(s.sleepQualityGood),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    final (icon, label) = switch (sleep.quality) {
      1 => (Icons.sentiment_dissatisfied, s.sleepQualityBad),
      2 => (Icons.sentiment_neutral, s.sleepQualityMedium),
      _ => (Icons.sentiment_satisfied, s.sleepQualityGood),
    };

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: ListTile(
        leading: Icon(icon),
        title: Text(s.sleepCardTitle),
        subtitle: Text(label),
        trailing: const Icon(Icons.chevron_right),
        dense: true,
        onTap: () => context.pushNamed(AppRouter.sleepEntry.name),
      ),
    );
  }
}
