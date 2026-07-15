import 'dart:async';

import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/enum_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Symptom entry form: type, intensity, optional detail/note, editable
/// timestamp. The default path (type + save) takes two taps.
///
/// When [draft] is provided, the form is seeded from that existing symptom
/// (edit path of US-12) and a delete action is offered.
class SymptomEntryScreen extends ConsumerStatefulWidget {
  /// Creates a [SymptomEntryScreen].
  const SymptomEntryScreen({this.draft, super.key});

  /// The symptom being edited, or `null` when creating a new one.
  final SymptomDraft? draft;

  @override
  ConsumerState<SymptomEntryScreen> createState() =>
      _SymptomEntryScreenState();
}

class _SymptomEntryScreenState extends ConsumerState<SymptomEntryScreen> {
  @override
  void initState() {
    super.initState();
    final draft = widget.draft;
    if (draft != null) {
      // Riverpod forbids mutating a provider from initState; defer to the
      // next microtask, before the first frame is presented.
      unawaited(
        Future.microtask(
          () => ref
              .read(symptomEntryControllerProvider.notifier)
              .loadForEdit(draft),
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
        .read(symptomEntryControllerProvider.notifier)
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
        .read(symptomEntryControllerProvider.notifier)
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

  Future<void> _pickEndTime(
    BuildContext context,
    WidgetRef ref,
    DateTime timestamp,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(timestamp),
    );
    if (picked == null) return;
    ref
        .read(symptomEntryControllerProvider.notifier)
        .setEndTime(
          DateTime(
            timestamp.year,
            timestamp.month,
            timestamp.day,
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
          await ref.read(symptomEntryControllerProvider.notifier).save();
      if (!saved) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.symptomSaved)));
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
    final id = ref.read(symptomEntryControllerProvider).id;
    if (id == null) return;
    // The screen pops after deleting, so capture the repository now rather
    // than reading `ref` again from the Undo action (the widget will
    // already be unmounted by then).
    final repository = ref.read(symptomEntryRepositoryProvider);
    try {
      final deleted =
          await ref.read(symptomEntryControllerProvider.notifier).delete();
      if (!deleted) return;
      router.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(s.entryDeleted),
            action: SnackBarAction(
              label: s.undoAction,
              onPressed: () => repository.undoDeleteSymptom(id),
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
    final state = ref.watch(symptomEntryControllerProvider);
    final notifier = ref.read(symptomEntryControllerProvider.notifier);
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final dateLabel = DateFormat.yMMMd(locale).format(state.timestamp);
    final timeLabel = DateFormat.Hm(locale).format(state.timestamp);
    final detailSuggestions = symptomDetailSuggestions(s, state.type);
    final isEditing = state.id != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? s.editSymptomTitle : s.symptomEntryTitle),
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
          Text(
            s.symptomEntryTypeLabel,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          gapH8,
          SegmentedButton<SymptomType>(
            segments: [
              for (final type in SymptomType.values)
                ButtonSegment(
                  value: type,
                  label: Text(
                    symptomTypeLabel(s, type),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
            ],
            selected: {state.type},
            onSelectionChanged: (selection) =>
                notifier.setType(selection.first),
          ),
          gapH16,
          Text(
            '${s.intensityLabel}: ${state.intensity}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Slider(
            value: state.intensity.toDouble(),
            max: 10,
            divisions: 10,
            label: '${state.intensity}',
            onChanged: (value) => notifier.setIntensity(value.round()),
          ),
          if (detailSuggestions.isNotEmpty) ...[
            gapH8,
            Text(s.detailLabel, style: Theme.of(context).textTheme.labelLarge),
            gapH8,
            Wrap(
              spacing: Sizes.p8,
              runSpacing: Sizes.p8,
              children: [
                for (final suggestion in detailSuggestions)
                  ChoiceChip(
                    label: Text(suggestion),
                    selected: state.detail == suggestion,
                    onSelected: (_) => notifier.toggleDetail(suggestion),
                  ),
              ],
            ),
          ],
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
          if (state.endTime == null)
            OutlinedButton.icon(
              onPressed: () => _pickEndTime(context, ref, state.timestamp),
              icon: const Icon(Icons.timer_outlined, size: Sizes.p16),
              label: Text(s.endTimeLabel),
            )
          else
            InputChip(
              avatar: const Icon(Icons.timer_outlined, size: Sizes.p16),
              label: Text(
                DateFormat.Hm(locale).format(state.endTime!),
              ),
              onDeleted: notifier.clearEndTime,
              deleteButtonTooltipMessage: s.removeEndTime,
            ),
          gapH16,
          TextField(
            decoration: InputDecoration(
              hintText: s.noteHint,
              border: const OutlineInputBorder(),
            ),
            maxLines: 2,
            onChanged: notifier.setNote,
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
