import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_controller.dart';
import 'package:assiette/features/meal_entry/presentation/widgets/photo_section.dart';
import 'package:assiette/features/meal_entry/presentation/widgets/tag_selector.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/enum_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Meal entry form: photo, meal type, tags, note, editable timestamp.
class MealEntryScreen extends ConsumerWidget {
  /// Creates a [MealEntryScreen].
  const MealEntryScreen({super.key});

  Future<void> _pickDate(
    BuildContext context,
    WidgetRef ref,
    DateTime current,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked == null) return;
    ref.read(mealEntryControllerProvider.notifier).setTimestamp(
          DateTime(
            picked.year,
            picked.month,
            picked.day,
            current.hour,
            current.minute,
          ),
        );
  }

  Future<void> _pickTime(
    BuildContext context,
    WidgetRef ref,
    DateTime current,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
    );
    if (picked == null) return;
    ref.read(mealEntryControllerProvider.notifier).setTimestamp(
          DateTime(
            current.year,
            current.month,
            current.day,
            picked.hour,
            picked.minute,
          ),
        );
  }

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final s = AppStrings.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      final saved =
          await ref.read(mealEntryControllerProvider.notifier).save();
      if (!saved) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.mealSaved)));
      router.pop();
    } on Exception {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final state = ref.watch(mealEntryControllerProvider);
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final dateLabel = DateFormat.yMMMd(locale).format(state.timestamp);
    final timeLabel = DateFormat.Hm(locale).format(state.timestamp);

    return Scaffold(
      appBar: AppBar(title: Text(s.mealEntryTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.p16),
        children: [
          const PhotoSection(),
          gapH16,
          Text(s.mealTypeLabel,
              style: Theme.of(context).textTheme.labelLarge),
          gapH8,
          SegmentedButton<MealType>(
            segments: [
              for (final type in MealType.values)
                ButtonSegment(
                  value: type,
                  label: Text(
                    mealTypeLabel(s, type),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
            ],
            selected: {state.mealType},
            onSelectionChanged: (selection) => ref
                .read(mealEntryControllerProvider.notifier)
                .setMealType(selection.first),
          ),
          gapH16,
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickDate(context, ref, state.timestamp),
                  icon: const Icon(Icons.calendar_today, size: Sizes.p16),
                  label: Text(dateLabel),
                ),
              ),
              gapW8,
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickTime(context, ref, state.timestamp),
                  icon: const Icon(Icons.schedule, size: Sizes.p16),
                  label: Text(timeLabel),
                ),
              ),
            ],
          ),
          gapH16,
          Text(s.tagsLabel, style: Theme.of(context).textTheme.labelLarge),
          gapH8,
          const TagSelector(),
          gapH16,
          TextField(
            decoration: InputDecoration(
              hintText: s.noteHint,
              border: const OutlineInputBorder(),
            ),
            maxLines: 2,
            onChanged:
                ref.read(mealEntryControllerProvider.notifier).setNote,
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
          gapH8,
          OutlinedButton(
            // Creates a MealTemplate — arrives with US-5.
            onPressed: () => ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(s.comingSoon))),
            child: Text(s.saveAsFavorite),
          ),
        ],
      ),
    );
  }
}
