import 'dart:math' as math;

import 'package:assiette/constants/app_colors.dart';
import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/migraine_stats/domain/migraine_stats.dart';
import 'package:assiette/features/migraine_stats/presentation/migraine_stats_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Dashboard summarizing migraine episodes and medication intakes.
class MigraineStatsScreen extends ConsumerWidget {
  /// Creates the migraine statistics screen.
  const MigraineStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final period = ref.watch(selectedMigraineStatsPeriodProvider);
    final stats = ref.watch(migraineStatsProvider(period));

    return Scaffold(
      appBar: AppBar(title: Text(s.migraineStatsTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Sizes.p16,
              Sizes.p8,
              Sizes.p16,
              Sizes.p8,
            ),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<MigraineStatsPeriod>(
                segments: [
                  ButtonSegment(
                    value: MigraineStatsPeriod.thirtyDays,
                    label: Text(s.migraineStatsPeriod30Days),
                  ),
                  ButtonSegment(
                    value: MigraineStatsPeriod.ninetyDays,
                    label: Text(s.migraineStatsPeriod90Days),
                  ),
                  ButtonSegment(
                    value: MigraineStatsPeriod.oneYear,
                    label: Text(s.migraineStatsPeriodOneYear),
                  ),
                ],
                selected: {period},
                showSelectedIcon: false,
                onSelectionChanged: (selection) => ref
                    .read(selectedMigraineStatsPeriodProvider.notifier)
                    .select(selection.single),
              ),
            ),
          ),
          Expanded(
            child: switch (stats) {
              AsyncData(:final value) => _StatsBody(stats: value),
              AsyncError() => _ErrorBody(
                onRetry: () => ref.invalidate(migraineStatsProvider(period)),
              ),
              _ => const Center(child: CircularProgressIndicator()),
            },
          ),
        ],
      ),
    );
  }
}

class _StatsBody extends ConsumerWidget {
  const _StatsBody({required this.stats});

  final MigraineStats stats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    if (stats.migraineCount == 0 && stats.medicationIntakeCount == 0) {
      return _EmptyBody(message: s.migraineStatsEmpty);
    }

    final period = ref.watch(selectedMigraineStatsPeriodProvider);
    return RefreshIndicator(
      onRefresh: () => ref.refresh(migraineStatsProvider(period).future),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          Sizes.p16,
          Sizes.p8,
          Sizes.p16,
          Sizes.p32,
        ),
        children: [
          _MetricsGrid(stats: stats),
          gapH24,
          _SectionTitle(title: s.migraineStatsFrequencyTitle),
          gapH8,
          _FrequencyCard(buckets: stats.frequency),
          gapH24,
          _SectionTitle(title: s.migraineStatsTreatmentsTitle),
          gapH8,
          if (stats.medications.isEmpty)
            _MessageCard(message: s.migraineStatsNoTreatments)
          else
            _TreatmentsCard(medications: stats.medications),
          gapH24,
          _Disclaimer(text: s.migraineStatsDisclaimer),
        ],
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid({required this.stats});

  final MigraineStats stats;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: Sizes.p8,
      crossAxisSpacing: Sizes.p8,
      childAspectRatio: 1.45,
      children: [
        _MetricCard(
          icon: Icons.bolt,
          accent: AppColors.alert,
          value: stats.migraineCount.toString(),
          label: s.migraineStatsCrisesLabel,
        ),
        _MetricCard(
          icon: Icons.calendar_today_outlined,
          accent: AppColors.warning,
          value: stats.migraineDays.toString(),
          label: s.migraineStatsDaysLabel,
        ),
        _MetricCard(
          icon: Icons.schedule,
          accent: AppColors.primary,
          value: _formatDuration(s, stats.averageDuration),
          label: s.migraineStatsAverageDurationLabel,
        ),
        _MetricCard(
          icon: Icons.show_chart,
          accent: AppColors.turquoise,
          value: stats.averageMaximumIntensity == null
              ? s.migraineStatsNotAvailable
              : s.migraineStatsIntensityValue(
                  stats.averageMaximumIntensity!.toStringAsFixed(1),
                ),
          label: s.migraineStatsAverageIntensityLabel,
        ),
        _MetricCard(
          icon: Icons.medication_outlined,
          accent: AppColors.primary,
          value: stats.medicationDays.toString(),
          label: s.migraineStatsMedicationDaysLabel,
          supporting: s.migraineStatsIntakeCount(stats.medicationIntakeCount),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.accent,
    required this.value,
    required this.label,
    this.supporting,
  });

  final IconData icon;
  final Color accent;
  final String value;
  final String label;
  final String? supporting;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: accent, size: 20),
            Text(value, style: theme.textTheme.headlineSmall),
            Text(label, style: theme.textTheme.bodySmall),
            if (supporting case final text?)
              Text(text, style: theme.textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}

class _FrequencyCard extends StatelessWidget {
  const _FrequencyCard({required this.buckets});

  final List<MigraineFrequencyBucket> buckets;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final dateFormat = DateFormat.MMMd(locale);
    final maxCount = buckets.fold<int>(
      1,
      (maximum, bucket) => math.max(maximum, bucket.count),
    );

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: SizedBox(
          height: 170,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var index = 0; index < buckets.length; index++)
                Expanded(
                  child: _FrequencyBar(
                    bucket: buckets[index],
                    maximum: maxCount,
                    label: index == 0 || index == buckets.length - 1
                        ? dateFormat.format(buckets[index].start.toLocal())
                        : null,
                    semanticLabel: s.migraineStatsFrequencyBucket(
                      dateFormat.format(buckets[index].start.toLocal()),
                      buckets[index].count,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FrequencyBar extends StatelessWidget {
  const _FrequencyBar({
    required this.bucket,
    required this.maximum,
    required this.semanticLabel,
    this.label,
  });

  final MigraineFrequencyBucket bucket;
  final int maximum;
  final String semanticLabel;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: semanticLabel,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            Text(
              bucket.count == 0 ? '' : bucket.count.toString(),
              style: theme.textTheme.labelSmall,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: bucket.count == 0
                      ? 0.02
                      : bucket.count / maximum,
                  widthFactor: 0.7,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: bucket.count == 0
                          ? AppColors.slate
                          : AppColors.alert,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: Sizes.p8),
            SizedBox(
              height: 16,
              child: Text(
                label ?? '',
                maxLines: 1,
                style: theme.textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TreatmentsCard extends StatelessWidget {
  const _TreatmentsCard({required this.medications});

  final List<MedicationStats> medications;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          for (var index = 0; index < medications.length; index++) ...[
            _MedicationTile(medication: medications[index]),
            if (index != medications.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}

class _MedicationTile extends StatelessWidget {
  const _MedicationTile({required this.medication});

  final MedicationStats medication;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final delay = medication.averageDelayAfterMigraineStart;
    return ListTile(
      key: ValueKey(medication.name.toLowerCase()),
      leading: const CircleAvatar(child: Icon(Icons.medication_outlined)),
      title: Text(medication.name),
      subtitle: Text(
        [
          s.migraineStatsIntakeCount(medication.intakeCount),
          s.migraineStatsLinkedCrises(medication.linkedMigraineCount),
          if (delay != null)
            s.migraineStatsAverageDelay(_formatDuration(s, delay)),
        ].join(' · '),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Text(
    title,
    style: Theme.of(context).textTheme.titleLarge,
  );
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(Icons.info_outline, size: 18, color: AppColors.textSecondary),
      gapW8,
      Expanded(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    ],
  );
}

class _EmptyBody extends StatelessWidget {
  const _EmptyBody({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(Sizes.p32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.insights_outlined, size: 48),
          gapH16,
          Text(message, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    child: Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Text(message),
    ),
  );
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(s.migraineStatsLoadError, textAlign: TextAlign.center),
            gapH16,
            FilledButton(onPressed: onRetry, child: Text(s.migraineStatsRetry)),
          ],
        ),
      ),
    );
  }
}

String _formatDuration(AppStrings s, Duration? duration) {
  if (duration == null) return s.migraineStatsNotAvailable;
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  return hours == 0
      ? s.migraineStatsDurationMinutes(minutes)
      : s.migraineStatsDurationHoursMinutes(hours, minutes);
}
