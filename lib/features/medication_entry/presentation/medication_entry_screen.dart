import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/medication_entry/domain/medication_entry_repository.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Autonomous medication intake form with one-tap recent medications.
class MedicationEntryScreen extends ConsumerStatefulWidget {
  const MedicationEntryScreen({this.initialDate, super.key});

  final DateTime? initialDate;

  @override
  ConsumerState<MedicationEntryScreen> createState() =>
      _MedicationEntryScreenState();
}

class _MedicationEntryScreenState extends ConsumerState<MedicationEntryScreen> {
  final _nameController = TextEditingController();
  late DateTime _timestamp;
  bool _linkToMigraine = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final date = widget.initialDate ?? now;
    _timestamp = DateTime(
      date.year,
      date.month,
      date.day,
      now.hour,
      now.minute,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final value = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_timestamp),
    );
    if (value == null) return;
    setState(() {
      _timestamp = DateTime(
        _timestamp.year,
        _timestamp.month,
        _timestamp.day,
        value.hour,
        value.minute,
      );
    });
  }

  Future<String?> _saveName(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty || _saving) return null;
    setState(() => _saving = true);
    try {
      final active = await ref.read(activeMigraineProvider.future);
      return ref
          .read(medicationEntryRepositoryProvider)
          .saveIntake(
            timestamp: _timestamp,
            name: trimmed,
            symptomId: _linkToMigraine ? active?.id : null,
          );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _quickSave(String name) async {
    final s = AppStrings.of(context);
    final repository = ref.read(medicationEntryRepositoryProvider);
    final id = await _saveName(name);
    if (id == null || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s.medicationSaved),
        action: SnackBarAction(
          label: s.undoAction,
          onPressed: () => repository.deleteIntake(id),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final id = await _saveName(_nameController.text);
    if (id != null && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final active = ref.watch(activeMigraineProvider).value;
    final recent = ref.watch(recentMedicationNamesProvider).value ?? const [];
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    return Scaffold(
      appBar: AppBar(title: Text(s.medicationEntryTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.p16),
        children: [
          if (recent.isNotEmpty) ...[
            Text(s.recentMedicationsTitle),
            gapH8,
            Wrap(
              spacing: Sizes.p8,
              runSpacing: Sizes.p8,
              children: [
                for (final name in recent)
                  ActionChip(
                    avatar: const Icon(Icons.add),
                    label: Text(name),
                    onPressed: _saving ? null : () => _quickSave(name),
                  ),
              ],
            ),
            gapH24,
          ],
          Text(
            s.newMedicationAction,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          gapH8,
          TextField(
            controller: _nameController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: s.medicationNameLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          gapH16,
          OutlinedButton.icon(
            onPressed: _pickTime,
            icon: const Icon(Icons.schedule),
            label: Text(DateFormat.Hm(locale).format(_timestamp)),
          ),
          if (active != null)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _linkToMigraine,
              title: Text(s.linkToActiveMigraine),
              onChanged: (value) =>
                  setState(() => _linkToMigraine = value ?? false),
            ),
          gapH24,
          FilledButton(
            onPressed: _saving ? null : _submit,
            child: Text(s.save),
          ),
        ],
      ),
    );
  }
}
