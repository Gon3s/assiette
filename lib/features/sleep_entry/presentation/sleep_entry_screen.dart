import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Sleep entry detail form: quality plus optional bed/wake time, for the
/// night already logged on the day view (edit path of US-7).
class SleepEntryScreen extends ConsumerWidget {
  /// Creates a [SleepEntryScreen].
  const SleepEntryScreen({super.key});

  Future<void> _pickBedTime(
    BuildContext context,
    WidgetRef ref,
    DateTime? current,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: current != null
          ? TimeOfDay.fromDateTime(current)
          : TimeOfDay.now(),
    );
    if (picked == null) return;
    final day = ref.read(selectedDateProvider);
    var date = current?.toLocal() ?? day;
    final wakeTime = ref.read(sleepEntryControllerProvider).wakeTime?.toLocal();
    if (current == null) {
      final previousDay = wakeTime == null
          ? picked.hour >= 12
          : picked.hour > wakeTime.hour ||
                (picked.hour == wakeTime.hour &&
                    picked.minute > wakeTime.minute);
      final wakeDay = wakeTime ?? day;
      date = DateTime(
        wakeDay.year,
        wakeDay.month,
        wakeDay.day - (previousDay ? 1 : 0),
      );
    }
    ref
        .read(sleepEntryControllerProvider.notifier)
        .setBedTime(
          DateTime(date.year, date.month, date.day, picked.hour, picked.minute),
        );
  }

  Future<void> _pickWakeTime(
    BuildContext context,
    WidgetRef ref,
    DateTime? current,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: current != null
          ? TimeOfDay.fromDateTime(current)
          : TimeOfDay.now(),
    );
    if (picked == null) return;
    final day = ref.read(selectedDateProvider);
    final date = current?.toLocal() ?? day;
    var year = date.year;
    var month = date.month;
    var dayOfMonth = date.day;
    final bedTime = ref.read(sleepEntryControllerProvider).bedTime?.toLocal();
    final candidate = DateTime(
      year,
      month,
      dayOfMonth,
      picked.hour,
      picked.minute,
    );
    if (current == null && bedTime != null && candidate.isBefore(bedTime)) {
      final nextDay = DateTime(bedTime.year, bedTime.month, bedTime.day + 1);
      year = nextDay.year;
      month = nextDay.month;
      dayOfMonth = nextDay.day;
    }
    ref
        .read(sleepEntryControllerProvider.notifier)
        .setWakeTime(
          DateTime(year, month, dayOfMonth, picked.hour, picked.minute),
        );
  }

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final s = AppStrings.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      final saved = await ref
          .read(sleepEntryControllerProvider.notifier)
          .save();
      if (!saved) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.sleepSaved)));
      router.pop();
    } on Exception {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final s = AppStrings.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    final id = ref.read(sleepEntryControllerProvider).id;
    if (id == null) return;
    // The screen pops after deleting, so capture the repository now rather
    // than reading `ref` again from the Undo action (the widget will
    // already be unmounted by then).
    final repository = ref.read(dayViewRepositoryProvider);
    try {
      final deleted = await ref
          .read(sleepEntryControllerProvider.notifier)
          .delete();
      if (!deleted) return;
      router.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(s.entryDeleted),
            action: SnackBarAction(
              label: s.undoAction,
              onPressed: () => repository.undoDeleteSleepEntry(id),
            ),
          ),
        );
    } on Exception {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final day = ref.watch(selectedDateProvider);
    final sleepProvider = daySleepProvider(day);
    final sleep = ref.watch(sleepProvider);
    if (!sleep.hasValue) {
      return Scaffold(
        appBar: AppBar(title: Text(s.sleepCardTitle)),
        body: Center(
          child: sleep.hasError
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(s.errorGeneric),
                    FilledButton(
                      onPressed: () => ref.invalidate(sleepProvider),
                      child: Text(s.retryAction),
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      );
    }
    final state = ref.watch(sleepEntryControllerProvider);
    final notifier = ref.read(sleepEntryControllerProvider.notifier);
    final locale = Localizations.maybeLocaleOf(context)?.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(s.sleepCardTitle),
        actions: [
          if (state.id != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: s.deleteAction,
              onPressed: () => _delete(context, ref),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.p16),
        children: [
          Text(
            s.sleepQualityLabel,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          gapH8,
          SegmentedButton<int>(
            segments: [
              ButtonSegment(value: 1, label: Text(s.sleepQualityBad)),
              ButtonSegment(value: 2, label: Text(s.sleepQualityMedium)),
              ButtonSegment(value: 3, label: Text(s.sleepQualityGood)),
            ],
            emptySelectionAllowed: true,
            selected: state.quality == null ? const <int>{} : {state.quality!},
            onSelectionChanged: (selection) => notifier.setQuality(
              selection.isEmpty ? null : selection.first,
            ),
          ),
          gapH16,
          TextFormField(
            initialValue: state.note,
            minLines: 2,
            maxLines: 4,
            maxLength: 500,
            decoration: InputDecoration(
              labelText: s.sleepNoteLabel,
              hintText: s.sleepNoteHint,
            ),
            onChanged: notifier.setNote,
          ),
          gapH16,
          Row(
            children: [
              Expanded(
                child: state.bedTime == null
                    ? OutlinedButton.icon(
                        onPressed: () =>
                            _pickBedTime(context, ref, state.bedTime),
                        icon: const Icon(
                          Icons.bedtime_outlined,
                          size: Sizes.p16,
                        ),
                        label: Text(s.bedTimeLabel),
                      )
                    : InputChip(
                        avatar: const Icon(
                          Icons.bedtime_outlined,
                          size: Sizes.p16,
                        ),
                        label: Text(
                          DateFormat.Hm(
                            locale,
                          ).format(state.bedTime!.toLocal()),
                        ),
                        onDeleted: notifier.clearBedTime,
                        deleteButtonTooltipMessage: s.removeBedTime,
                      ),
              ),
              gapW8,
              Expanded(
                child: state.wakeTime == null
                    ? OutlinedButton.icon(
                        onPressed: () =>
                            _pickWakeTime(context, ref, state.wakeTime),
                        icon: const Icon(
                          Icons.wb_sunny_outlined,
                          size: Sizes.p16,
                        ),
                        label: Text(s.wakeTimeLabel),
                      )
                    : InputChip(
                        avatar: const Icon(
                          Icons.wb_sunny_outlined,
                          size: Sizes.p16,
                        ),
                        label: Text(
                          DateFormat.Hm(
                            locale,
                          ).format(state.wakeTime!.toLocal()),
                        ),
                        onDeleted: notifier.clearWakeTime,
                        deleteButtonTooltipMessage: s.removeWakeTime,
                      ),
              ),
            ],
          ),
          gapH24,
          FilledButton(
            onPressed: state.isSaving ? null : () => _save(context, ref),
            child: state.isSaving
                ? const SizedBox(
                    height: Sizes.p20,
                    width: Sizes.p20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(s.save),
          ),
        ],
      ),
    );
  }
}
