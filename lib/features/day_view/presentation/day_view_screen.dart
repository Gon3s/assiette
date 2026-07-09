import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/day_view/presentation/widgets/day_header.dart';
import 'package:assiette/features/day_view/presentation/widgets/sleep_card.dart';
import 'package:assiette/features/day_view/presentation/widgets/timeline_tile.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Home screen: everything logged for the selected day, as a timeline.
class DayViewScreen extends ConsumerWidget {
  /// Creates a [DayViewScreen].
  const DayViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final date = ref.watch(selectedDateProvider);
    final timeline = ref.watch(dayTimelineProvider);

    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final title =
        isToday ? s.today : DateFormat.MMMMEEEEd(locale).format(date);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          const DayHeader(),
          const SleepCard(),
          gapH8,
          Expanded(
            child: switch (timeline) {
              AsyncData(:final value) when value.isEmpty => Center(
                  child: Text(
                    s.emptyDayMessage,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              AsyncData(:final value) => ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) =>
                      TimelineTile(item: value[index]),
                ),
              AsyncError() => Center(child: Text(s.emptyDayMessage)),
              _ => const Center(child: CircularProgressIndicator()),
            },
          ),
          _ActionBar(s: s),
        ],
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.s});

  final AppStrings s;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () =>
                    context.pushNamed(AppRouter.mealEntry.name),
                icon: const Icon(Icons.photo_camera),
                label: Text(s.logMealAction),
              ),
            ),
            gapW16,
            Expanded(
              child: FilledButton.tonalIcon(
                onPressed: () =>
                    context.pushNamed(AppRouter.symptomEntry.name),
                icon: const Icon(Icons.healing),
                label: Text(s.logSymptomAction),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
