import 'dart:io';

import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/day_timeline/domain/timeline_item.dart';
import 'package:assiette/features/day_timeline/presentation/day_timeline_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// The main home screen showing the day timeline.
class DayTimelineScreen extends ConsumerWidget {
  /// Creates a [DayTimelineScreen].
  const DayTimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(selectedDateProvider);
    final s = AppStrings.of(context);
    final locale = Localizations.localeOf(context).toString();
    final raw = DateFormat('EEEE d MMMM', locale).format(date);
    final title = '${raw[0].toUpperCase()}${raw.substring(1)}';

    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: false),
      body: const Column(
        children: [
          _EnvHeader(),
          _SleepCard(),
          _FavoritesRow(),
          Expanded(child: _TimelineList()),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p16,
            vertical: Sizes.p12,
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: Text(s.addMealPhoto),
                ),
              ),
              gapW12,
              Expanded(
                child: FilledButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.warning_amber_rounded),
                  label: Text(s.addSymptom),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EnvHeader extends ConsumerWidget {
  const _EnvHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final env = ref.watch(latestEnvForDayProvider).value;
    if (env == null) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p8,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.p16,
          vertical: Sizes.p12,
        ),
        child: Row(
          children: [
            if (env.temperature != null) ...[
              const Icon(Icons.thermostat, size: 20),
              gapW4,
              Text('${env.temperature!.toStringAsFixed(1)} °C'),
              gapW16,
            ],
            if (env.pressure != null) ...[
              const Icon(Icons.speed, size: 20),
              gapW4,
              Text('${env.pressure!.toStringAsFixed(0)} hPa'),
            ],
          ],
        ),
      ),
    );
  }
}

class _SleepCard extends ConsumerWidget {
  const _SleepCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final sleep = ref.watch(sleepForDayProvider).value;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p4,
      ),
      child: ListTile(
        leading: const Icon(Icons.bedtime),
        title: sleep == null
            ? Text(s.sleepCardNoData)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < sleep.quality; i++)
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                  for (var i = 0; i < 3 - sleep.quality; i++)
                    const Icon(Icons.star_border, size: 16),
                ],
              ),
        subtitle: sleep != null &&
                sleep.bedTime != null &&
                sleep.wakeTime != null
            ? Text(
                '${TimeOfDay.fromDateTime(sleep.bedTime!.toLocal()).format(context)}'
                ' – '
                '${TimeOfDay.fromDateTime(sleep.wakeTime!.toLocal()).format(context)}',
              )
            : null,
      ),
    );
  }
}

class _FavoritesRow extends StatelessWidget {
  const _FavoritesRow();

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p4,
      ),
      child: Row(
        children: [
          const Icon(Icons.star_outline, size: 20),
          gapW8,
          Text(
            s.favoritesComingSoon,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _TimelineList extends ConsumerWidget {
  const _TimelineList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    return ref.watch(dayTimelineProvider).when(
          data: (items) => items.isEmpty
              ? _EmptyTimeline(message: s.nothingLoggedToday)
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: Sizes.p16),
                  itemCount: items.length,
                  itemBuilder: (ctx, i) => switch (items[i]) {
                    MealItem(:final meal, :final tags) =>
                      _MealTile(meal: meal, tags: tags),
                    SymptomItem(:final symptom) =>
                      _SymptomTile(symptom: symptom),
                  },
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
        );
  }
}

class _EmptyTimeline extends StatelessWidget {
  const _EmptyTimeline({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          gapH16,
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}

class _MealTile extends StatelessWidget {
  const _MealTile({required this.meal, required this.tags});
  final Meal meal;
  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final time = TimeOfDay.fromDateTime(meal.timestamp.toLocal());

    return ListTile(
      leading: meal.photoPath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.p8),
              child: Image.file(
                File(meal.photoPath!),
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            )
          : CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(_mealIcon(meal.mealType)),
            ),
      title: Text(_mealTypeLabel(meal.mealType, s)),
      subtitle: tags.isEmpty
          ? null
          : Wrap(
              spacing: Sizes.p4,
              runSpacing: Sizes.p4,
              children: [
                for (final tag in tags)
                  Chip(
                    label: Text(tag.label),
                    padding: EdgeInsets.zero,
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: Sizes.p8),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
      trailing: Text(
        time.format(context),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  IconData _mealIcon(MealType type) => switch (type) {
        MealType.breakfast => Icons.free_breakfast,
        MealType.lunch => Icons.lunch_dining,
        MealType.dinner => Icons.dinner_dining,
        MealType.snack => Icons.fastfood,
      };

  String _mealTypeLabel(MealType type, AppStrings s) => switch (type) {
        MealType.breakfast => s.mealTypeBreakfast,
        MealType.lunch => s.mealTypeLunch,
        MealType.dinner => s.mealTypeDinner,
        MealType.snack => s.mealTypeSnack,
      };
}

class _SymptomTile extends StatelessWidget {
  const _SymptomTile({required this.symptom});
  final Symptom symptom;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final time = TimeOfDay.fromDateTime(symptom.timestamp.toLocal());
    final color = _symptomColor(symptom.type);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.2),
        child: Icon(Icons.circle, color: color, size: 20),
      ),
      title: Text(_symptomTypeLabel(symptom.type, s)),
      subtitle: Text('${s.intensityLabel}: ${symptom.intensity}'),
      trailing: Text(
        time.format(context),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Color _symptomColor(SymptomType type) => switch (type) {
        SymptomType.migraine => Colors.red.shade400,
        SymptomType.digestive => Colors.amber.shade600,
        SymptomType.mood => Colors.blue.shade400,
      };

  String _symptomTypeLabel(SymptomType type, AppStrings s) => switch (type) {
        SymptomType.migraine => s.symptomTypeMigraine,
        SymptomType.digestive => s.symptomTypeDigestive,
        SymptomType.mood => s.symptomTypeMood,
      };
}
