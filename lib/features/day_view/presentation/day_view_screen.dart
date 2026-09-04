import 'dart:async';

import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_repository.dart';
import 'package:assiette/features/cloud_backup/presentation/cloud_backup_controller.dart';
import 'package:assiette/features/cloud_backup/presentation/cloud_backup_state.dart';
import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/day_view/presentation/widgets/day_header.dart';
import 'package:assiette/features/day_view/presentation/widgets/sleep_card.dart';
import 'package:assiette/features/day_view/presentation/widgets/timeline_tile.dart';
import 'package:assiette/features/favorites/presentation/widgets/favorites_row.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/enum_labels.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Reference date for day 0 of the day-navigation [PageView].
///
/// Kept in UTC so [_pageForDate] never crosses a local DST boundary: a
/// local-time diff between a winter epoch and a summer "today" loses an
/// hour to the clock shift, and [Duration.inDays] truncates that into an
/// off-by-one page.
final _epoch = DateTime.utc(2000);

/// Number of days reachable by swiping around [_epoch] (~135 years).
const _pageCount = 50000;

int _pageForDate(DateTime date) =>
    DateTime.utc(date.year, date.month, date.day).difference(_epoch).inDays;

DateTime _dateForPage(int page) {
  final utc = _epoch.add(Duration(days: page));
  return DateTime(utc.year, utc.month, utc.day);
}

/// Home screen: everything logged for the selected day, as a timeline.
///
/// Wraps the day content in a [PageView] so the user can swipe between
/// days; a date picker and a "today" shortcut are also offered in the
/// app bar (US-11).
class DayViewScreen extends ConsumerStatefulWidget {
  /// Creates a [DayViewScreen].
  const DayViewScreen({super.key});

  @override
  ConsumerState<DayViewScreen> createState() => _DayViewScreenState();
}

class _DayViewScreenState extends ConsumerState<DayViewScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _pageForDate(ref.read(selectedDateProvider)),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    ref.read(selectedDateProvider.notifier).select(_dateForPage(page));
  }

  Future<void> _offerRestore(BuildContext context, AppStrings s) async {
    final restore = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.cloudRestorePromptTitle),
        content: Text(s.cloudRestorePromptBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(s.cloudRestorePromptLater),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(s.cloudRestoreAction),
          ),
        ],
      ),
    );
    if (!context.mounted) return;
    final notifier = ref.read(cloudBackupControllerProvider.notifier);
    if (restore != true) {
      await notifier.dismissRestoreOffer();
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    final outcome = await notifier.restoreLatest();
    final message = switch (outcome) {
      RestoreOutcome.success => s.cloudRestoreSuccess,
      RestoreOutcome.notFound => s.cloudRestoreNoBackupFound,
      RestoreOutcome.failure => s.cloudRestoreFailure,
    };
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickDate(DateTime current) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: _epoch,
      lastDate: _dateForPage(_pageCount - 1),
    );
    if (picked != null) {
      ref.read(selectedDateProvider.notifier).select(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final date = ref.watch(selectedDateProvider);

    // Keep the PageView in sync when the date changes from outside a
    // swipe (the "today" shortcut or the date picker).
    ref
      ..listen(selectedDateProvider, (previous, next) {
        final targetPage = _pageForDate(next);
        if (_pageController.hasClients &&
            _pageController.page?.round() != targetPage) {
          _pageController.jumpToPage(targetPage);
        }
      })
      // Startup restore offer (US-26): fires once per app session, at
      // most, when a Drive backup is found for a silently-restored Google
      // session.
      ..listen(shouldOfferRestoreProvider, (previous, next) {
        if (next.value != true) return;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) unawaited(_offerRestore(context, s));
        });
      });

    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final title = isToday ? s.today : DateFormat.MMMMEEEEd(locale).format(date);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _pickDate(date),
          child: Text(title),
        ),
        actions: [
          if (!isToday)
            IconButton(
              icon: const Icon(Icons.today),
              tooltip: s.today,
              onPressed: () =>
                  ref.read(selectedDateProvider.notifier).goToToday(),
            ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () => _pickDate(date),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => context.pushNamed(AppRouter.settings.name),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pageCount,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, page) => const _DayViewBody(),
      ),
    );
  }
}

class _DayViewBody extends ConsumerWidget {
  const _DayViewBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final timeline = ref.watch(dayTimelineProvider);

    return Column(
      children: [
        const DayHeader(),
        const _ActiveMigraineCard(),
        const _DailyFeelingsCard(),
        const SleepCard(),
        gapH8,
        const FavoritesRow(),
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
              itemBuilder: (context, index) => TimelineTile(item: value[index]),
            ),
            AsyncError() => Center(child: Text(s.emptyDayMessage)),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
        _ActionBar(s: s),
      ],
    );
  }
}

class _ActionBar extends ConsumerWidget {
  const _ActionBar({required this.s});

  final AppStrings s;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () => context.pushNamed(AppRouter.mealEntry.name),
                icon: const Icon(Icons.photo_camera),
                label: Text(s.logMealAction),
              ),
            ),
            gapW16,
            Expanded(
              child: FilledButton.tonalIcon(
                onPressed: () => _showAddMenu(context, ref),
                icon: const Icon(Icons.add),
                label: Text(s.addHealthAction),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddMenu(BuildContext context, WidgetRef ref) async {
    final date = ref.read(selectedDateProvider);
    final choice = await showModalBottomSheet<_AddChoice>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.bolt),
              title: Text(s.symptomTypeMigraine),
              onTap: () => Navigator.pop(context, _AddChoice.migraine),
            ),
            ListTile(
              leading: const Icon(Icons.favorite_outline),
              title: Text(s.dailyFeelingTitle),
              onTap: () => Navigator.pop(context, _AddChoice.feeling),
            ),
            ListTile(
              leading: const Icon(Icons.mood),
              title: Text(s.dailyMoodTitle),
              onTap: () => Navigator.pop(context, _AddChoice.mood),
            ),
            ListTile(
              leading: const Icon(Icons.medication_outlined),
              title: Text(s.medicationEntryTitle),
              onTap: () => Navigator.pop(context, _AddChoice.medication),
            ),
          ],
        ),
      ),
    );
    if (choice == null || !context.mounted) return;
    if (choice == _AddChoice.medication) {
      await context.pushNamed(AppRouter.medicationEntry.name, extra: date);
      return;
    }
    if (choice == _AddChoice.mood) {
      final existing = await ref
          .read(symptomEntryRepositoryProvider)
          .loadDailyMood(date);
      if (!context.mounted) return;
      await context.pushNamed(
        AppRouter.symptomEntry.name,
        extra: existing,
        queryParameters: {
          'type': SymptomType.mood.name,
          'date': date.toIso8601String(),
        },
      );
      return;
    }
    final type = choice == _AddChoice.migraine
        ? SymptomType.migraine
        : SymptomType.digestive;
    await context.pushNamed(
      AppRouter.symptomEntry.name,
      queryParameters: {
        'type': type.name,
        'date': date.toIso8601String(),
      },
    );
  }
}

enum _AddChoice { migraine, feeling, mood, medication }

class _DailyFeelingsCard extends ConsumerWidget {
  const _DailyFeelingsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final feelings = ref.watch(dayFeelingsProvider).value ?? const [];
    if (feelings.isEmpty) return const SizedBox.shrink();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.dailyFeelingsCardTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            for (final feeling in feelings)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(symptomTypeLabel(s, feeling.type)),
                subtitle: feeling.text.isEmpty ? null : Text(feeling.text),
                onTap: () async {
                  final draft = await ref
                      .read(symptomEntryRepositoryProvider)
                      .loadSymptom(feeling.id);
                  if (draft != null && context.mounted) {
                    await context.pushNamed(
                      AppRouter.symptomEntry.name,
                      extra: draft,
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _ActiveMigraineCard extends ConsumerWidget {
  const _ActiveMigraineCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final active = ref.watch(activeMigraineProvider).value;
    if (active == null) return const SizedBox.shrink();
    final duration = active.startedAt == null
        ? s.migraineStartUnknown
        : s.migraineDuration(
            _formatDuration(
              DateTime.now().difference(
                active.startedAt!.toLocal(),
              ),
            ),
          );
    return Card(
      margin: const EdgeInsets.fromLTRB(
        Sizes.p16,
        Sizes.p8,
        Sizes.p16,
        Sizes.p8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.activeMigraineTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            gapH8,
            Text('$duration · ${s.intensityLabel} ${active.lastIntensity}/10'),
            gapH8,
            Wrap(
              spacing: Sizes.p8,
              children: [
                OutlinedButton(
                  onPressed: () => _updateIntensity(context, ref, active.id),
                  child: Text(s.updateIntensityAction),
                ),
                FilledButton.tonal(
                  onPressed: () => _end(context, ref, active.id),
                  child: Text(s.endMigraineAction),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateIntensity(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final intensity = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.of(context).updateIntensityAction),
        content: Wrap(
          spacing: Sizes.p8,
          runSpacing: Sizes.p8,
          children: [
            for (var value = 1; value <= 10; value++)
              ActionChip(
                label: Text('$value'),
                onPressed: () => Navigator.pop(context, value),
              ),
          ],
        ),
      ),
    );
    if (intensity != null) {
      await ref
          .read(dayViewRepositoryProvider)
          .addMigraineIntensity(id, intensity);
    }
  }

  Future<void> _end(BuildContext context, WidgetRef ref, String id) async {
    final now = DateTime.now();
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );
    if (time == null) return;
    await ref
        .read(dayViewRepositoryProvider)
        .endMigraine(
          id,
          DateTime(now.year, now.month, now.day, time.hour, time.minute),
        );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return hours == 0 ? '${minutes}m' : '${hours}h ${minutes}m';
  }
}
