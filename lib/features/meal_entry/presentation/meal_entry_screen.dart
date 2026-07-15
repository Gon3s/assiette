import 'dart:async';

import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/meal_entry/domain/meal_draft.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
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
///
/// When [draft] is provided, the form is seeded from that existing meal
/// (edit path of US-12) and a delete action is offered.
class MealEntryScreen extends ConsumerStatefulWidget {
  /// Creates a [MealEntryScreen].
  const MealEntryScreen({this.draft, super.key});

  /// The meal being edited, or `null` when creating a new one.
  final MealDraft? draft;

  @override
  ConsumerState<MealEntryScreen> createState() => _MealEntryScreenState();
}

class _MealEntryScreenState extends ConsumerState<MealEntryScreen> {
  @override
  void initState() {
    super.initState();
    final draft = widget.draft;
    if (draft != null) {
      // Riverpod forbids mutating a provider from initState; defer to the
      // next microtask, before the first frame is presented.
      unawaited(
        Future.microtask(
          () =>
              ref.read(mealEntryControllerProvider.notifier).loadForEdit(draft),
        ),
      );
    }
  }

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
    ref
        .read(mealEntryControllerProvider.notifier)
        .setTimestamp(
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
    ref
        .read(mealEntryControllerProvider.notifier)
        .setTimestamp(
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
      final saved = await ref.read(mealEntryControllerProvider.notifier).save();
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

  Future<String?> _promptFavoriteName(BuildContext context, AppStrings s) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(s.favoriteNameTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: s.favoriteNameHint),
          onSubmitted: (value) => Navigator.of(dialogContext).pop(
            value.trim().isEmpty ? null : value.trim(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () {
              final trimmed = controller.text.trim();
              Navigator.of(dialogContext).pop(trimmed.isEmpty ? null : trimmed);
            },
            child: Text(s.confirm),
          ),
        ],
      ),
    );
  }

  Future<void> _saveAsFavorite(BuildContext context, WidgetRef ref) async {
    final s = AppStrings.of(context);
    final name = await _promptFavoriteName(context, s);
    if (name == null || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final saved = await ref
          .read(mealEntryControllerProvider.notifier)
          .saveAsFavorite(name);
      if (!saved) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.favoriteSaved)));
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
    final id = ref.read(mealEntryControllerProvider).id;
    if (id == null) return;
    // The screen pops after deleting, so capture the repository now rather
    // than reading `ref` again from the Undo action (the widget will
    // already be unmounted by then).
    final repository = ref.read(mealEntryRepositoryProvider);
    try {
      final deleted = await ref.read(mealEntryControllerProvider.notifier).delete();
      if (!deleted) return;
      router.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(s.entryDeleted),
            action: SnackBarAction(
              label: s.undoAction,
              onPressed: () => repository.undoDeleteMeal(id),
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
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final state = ref.watch(mealEntryControllerProvider);
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final dateLabel = DateFormat.yMMMd(locale).format(state.timestamp);
    final timeLabel = DateFormat.Hm(locale).format(state.timestamp);
    final isEditing = state.id != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? s.editMealTitle : s.mealEntryTitle),
        actions: [
          if (isEditing)
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
          const PhotoSection(),
          gapH16,
          Text(s.mealTypeLabel, style: Theme.of(context).textTheme.labelLarge),
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
            onChanged: ref.read(mealEntryControllerProvider.notifier).setNote,
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
            onPressed: state.isSaving
                ? null
                : () => _saveAsFavorite(context, ref),
            child: Text(s.saveAsFavorite),
          ),
        ],
      ),
    );
  }
}
