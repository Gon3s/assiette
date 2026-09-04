import 'dart:async';

import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/enum_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Entry form adapted to either a timed migraine or an untimed daily note.
class SymptomEntryScreen extends ConsumerStatefulWidget {
  const SymptomEntryScreen({
    this.draft,
    this.initialType = SymptomType.migraine,
    this.initialDate,
    super.key,
  });

  final SymptomDraft? draft;
  final SymptomType initialType;
  final DateTime? initialDate;

  @override
  ConsumerState<SymptomEntryScreen> createState() => _SymptomEntryScreenState();
}

class _SymptomEntryScreenState extends ConsumerState<SymptomEntryScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(
      Future.microtask(() {
        final notifier = ref.read(symptomEntryControllerProvider.notifier);
        final draft = widget.draft;
        if (draft != null) return notifier.loadForEdit(draft);
        notifier.initialize(
          widget.initialType,
          widget.initialDate ?? DateTime.now(),
        );
      }),
    );
  }

  Future<void> _pickStart(DateTime current, {required bool date}) async {
    final notifier = ref.read(symptomEntryControllerProvider.notifier);
    if (date) {
      final picked = await showDatePicker(
        context: context,
        initialDate: current,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(days: 1)),
      );
      if (picked == null) return;
      notifier.setTimestamp(
        DateTime(
          picked.year,
          picked.month,
          picked.day,
          current.hour,
          current.minute,
        ),
      );
      return;
    }
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
    );
    if (picked != null) {
      notifier.setTimestamp(
        DateTime(
          current.year,
          current.month,
          current.day,
          picked.hour,
          picked.minute,
        ),
      );
    }
  }

  Future<void> _pickEnd(DateTime current, {required bool date}) async {
    final notifier = ref.read(symptomEntryControllerProvider.notifier);
    if (date) {
      final picked = await showDatePicker(
        context: context,
        initialDate: current,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(days: 1)),
      );
      if (picked == null) return;
      notifier.setEndTime(
        DateTime(
          picked.year,
          picked.month,
          picked.day,
          current.hour,
          current.minute,
        ),
      );
      return;
    }
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
    );
    if (picked != null) {
      notifier.setEndTime(
        DateTime(
          current.year,
          current.month,
          current.day,
          picked.hour,
          picked.minute,
        ),
      );
    }
  }

  Future<void> _addEndTime(DateTime start) async {
    final now = DateTime.now();
    final initial = now.isBefore(start) ? start : now;
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(start.year, start.month, start.day),
      lastDate: now.add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;
    ref
        .read(symptomEntryControllerProvider.notifier)
        .setEndTime(
          DateTime(date.year, date.month, date.day, time.hour, time.minute),
        );
  }

  Future<bool> _offerToEndActiveMigraine(AppStrings s) async {
    final active = await ref.read(activeMigraineProvider.future);
    if (active == null || !mounted) return false;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.activeMigraineExistsTitle),
        content: Text(s.activeMigraineExistsBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(s.endMigraineAction),
          ),
        ],
      ),
    );
    if (confirmed != true) return false;
    final now = DateTime.now();
    if (!mounted) return false;
    final endTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );
    if (endTime == null) return false;
    await ref
        .read(dayViewRepositoryProvider)
        .endMigraine(
          active.id,
          DateTime(
            now.year,
            now.month,
            now.day,
            endTime.hour,
            endTime.minute,
          ),
        );
    return true;
  }

  Future<void> _save(AppStrings s) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final saved = await ref
          .read(symptomEntryControllerProvider.notifier)
          .save();
      if (!saved || !mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(s.symptomSaved)));
      context.pop();
    } on ActiveMigraineExistsException {
      if (await _offerToEndActiveMigraine(s) && mounted) await _save(s);
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
  }

  Future<void> _delete(AppStrings s) async {
    final state = ref.read(symptomEntryControllerProvider);
    final id = state.id;
    if (id == null) return;
    final repository = ref.read(symptomEntryRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    if (!await ref.read(symptomEntryControllerProvider.notifier).delete()) {
      return;
    }
    if (!mounted) return;
    context.pop();
    messenger.showSnackBar(
      SnackBar(
        content: Text(s.entryDeleted),
        action: SnackBarAction(
          label: s.undoAction,
          onPressed: () => repository.undoDeleteSymptom(id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final state = ref.watch(symptomEntryControllerProvider);
    final notifier = ref.read(symptomEntryControllerProvider.notifier);
    final isMigraine = state.type == SymptomType.migraine;
    final isMood = state.type == SymptomType.mood;
    final locale = Localizations.maybeLocaleOf(context)?.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.id != null
              ? s.editSymptomTitle
              : isMigraine
              ? s.migraineEntryTitle
              : isMood
              ? s.dailyMoodTitle
              : s.dailyFeelingTitle,
        ),
        actions: [
          if (state.id != null)
            IconButton(
              onPressed: () => _delete(s),
              tooltip: s.deleteAction,
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.p16),
        children: [
          if (isMigraine) ...[
            Text(s.migraineStartLabel),
            gapH8,
            SegmentedButton<MigraineStartPrecision>(
              segments: [
                ButtonSegment(
                  value: MigraineStartPrecision.exact,
                  label: Text(s.migraineStartExact),
                ),
                ButtonSegment(
                  value: MigraineStartPrecision.approximate,
                  label: Text(s.migraineStartApproximate),
                ),
                ButtonSegment(
                  value: MigraineStartPrecision.unknown,
                  label: Text(s.migraineStartUnknown),
                ),
              ],
              selected: {state.startPrecision},
              onSelectionChanged: (value) =>
                  notifier.setStartPrecision(value.first),
            ),
            if (state.startPrecision != MigraineStartPrecision.unknown) ...[
              gapH16,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickStart(state.timestamp, date: true),
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        DateFormat.yMMMd(locale).format(state.timestamp),
                      ),
                    ),
                  ),
                  gapW8,
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickStart(state.timestamp, date: false),
                      icon: const Icon(Icons.schedule),
                      label: Text(
                        DateFormat.Hm(locale).format(state.timestamp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            gapH24,
            Text(s.intensityLabel),
            gapH8,
            Wrap(
              spacing: Sizes.p8,
              runSpacing: Sizes.p8,
              children: [
                for (var intensity = 1; intensity <= 10; intensity++)
                  ChoiceChip(
                    label: Text('$intensity'),
                    selected: state.intensity == intensity,
                    onSelected: (_) => notifier.setIntensity(intensity),
                  ),
              ],
            ),
            if (state.id != null) ...[
              gapH24,
              Text(s.migraineEndLabel),
              gapH8,
              if (state.endTime case final end?)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _pickEnd(end, date: true),
                        icon: const Icon(Icons.calendar_today),
                        label: Text(DateFormat.yMMMd(locale).format(end)),
                      ),
                    ),
                    gapW8,
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _pickEnd(end, date: false),
                        icon: const Icon(Icons.schedule),
                        label: Text(DateFormat.Hm(locale).format(end)),
                      ),
                    ),
                    IconButton(
                      onPressed: notifier.clearEndTime,
                      tooltip: s.removeEndTime,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                )
              else
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () => _addEndTime(state.timestamp),
                    icon: const Icon(Icons.schedule),
                    label: Text(s.endTimeLabel),
                  ),
                ),
              gapH24,
              Text(s.maximumIntensityLabel),
              gapH8,
              Wrap(
                spacing: Sizes.p8,
                runSpacing: Sizes.p8,
                children: [
                  for (
                    var intensity = state.intensity;
                    intensity <= 10;
                    intensity++
                  )
                    ChoiceChip(
                      label: Text('$intensity'),
                      selected: state.maximumIntensity == intensity,
                      onSelected: (selected) => notifier.setMaximumIntensity(
                        selected ? intensity : null,
                      ),
                    ),
                ],
              ),
            ],
          ] else ...[
            if (!isMood) ...[
              Text(s.feelingCategoryLabel),
              gapH8,
              SegmentedButton<SymptomType>(
                segments: [
                  for (final type in const [
                    SymptomType.digestive,
                    SymptomType.pain,
                    SymptomType.eczema,
                  ])
                    ButtonSegment(
                      value: type,
                      label: Text(symptomTypeLabel(s, type)),
                    ),
                ],
                selected: {state.type},
                onSelectionChanged: (value) => notifier.setType(value.first),
              ),
              gapH16,
            ],
            if (state.previousIntensity case final intensity?) ...[
              Text(s.previousIntensity(intensity)),
              gapH16,
            ],
          ],
          gapH16,
          TextFormField(
            key: ValueKey('${state.id}-${state.type}'),
            initialValue: state.note.isEmpty ? state.detail : state.note,
            decoration: InputDecoration(
              labelText: isMigraine ? s.noteHint : s.dailyNoteHint,
              border: const OutlineInputBorder(),
            ),
            minLines: 2,
            maxLines: 4,
            onChanged: notifier.setNote,
          ),
          gapH24,
          FilledButton(
            onPressed: state.isSaving ? null : () => _save(s),
            child: state.isSaving
                ? const SizedBox.square(
                    dimension: Sizes.p20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(s.save),
          ),
        ],
      ),
    );
  }
}
