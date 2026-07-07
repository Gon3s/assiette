import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Card showing the sleep quality logged for the selected day's night.
///
/// One-tap logging when the night is missing arrives with US-7; for now
/// the card is display-only.
class SleepCard extends ConsumerWidget {
  /// Creates a [SleepCard].
  const SleepCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final sleep = ref.watch(daySleepProvider).value;

    final quality = sleep?.quality;
    var label = s.sleepNotLogged;
    var icon = Icons.bedtime_outlined;
    if (quality == 1) {
      label = s.sleepQualityBad;
      icon = Icons.sentiment_dissatisfied;
    } else if (quality == 2) {
      label = s.sleepQualityMedium;
      icon = Icons.sentiment_neutral;
    } else if (quality == 3) {
      label = s.sleepQualityGood;
      icon = Icons.sentiment_satisfied;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: ListTile(
        leading: Icon(icon),
        title: Text(s.sleepCardTitle),
        subtitle: Text(label),
        dense: true,
      ),
    );
  }
}
