import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/data/db/enums/migraine_laterality.dart';
import 'package:assiette/data/db/enums/migraine_location.dart';
import 'package:assiette/features/symptom_entry/domain/migraine_observation.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Dialog used to create or edit one timestamped migraine observation.
class MigraineObservationDialog extends ConsumerStatefulWidget {
  /// Creates an observation form.
  const MigraineObservationDialog({
    this.observation,
    this.initialIntensity = 5,
    super.key,
  });

  /// Existing observation when editing.
  final MigraineObservation? observation;

  /// Suggested intensity for a new observation.
  final int initialIntensity;

  @override
  ConsumerState<MigraineObservationDialog> createState() =>
      _MigraineObservationDialogState();
}

class _MigraineObservationDialogState
    extends ConsumerState<MigraineObservationDialog> {
  late DateTime _timestamp;
  late int _intensity;
  MigraineLaterality? _laterality;
  MigraineLocation? _location;
  late _Presence _aura;
  late _Presence _nausea;
  late _Presence _photophobia;
  late _Presence _phonophobia;
  late String _note;

  @override
  void initState() {
    super.initState();
    final observation = widget.observation;
    _timestamp = observation?.timestamp.toLocal() ?? DateTime.now();
    _intensity = observation?.intensity ?? widget.initialIntensity;
    _laterality = observation?.laterality;
    _location = observation?.location;
    _aura = _Presence.fromValue(value: observation?.aura);
    _nausea = _Presence.fromValue(value: observation?.nausea);
    _photophobia = _Presence.fromValue(value: observation?.photophobia);
    _phonophobia = _Presence.fromValue(value: observation?.phonophobia);
    _note = observation?.note ?? '';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _timestamp,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked == null) return;
    setState(() {
      _timestamp = DateTime(
        picked.year,
        picked.month,
        picked.day,
        _timestamp.hour,
        _timestamp.minute,
      );
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_timestamp),
    );
    if (picked == null) return;
    setState(() {
      _timestamp = DateTime(
        _timestamp.year,
        _timestamp.month,
        _timestamp.day,
        picked.hour,
        picked.minute,
      );
    });
  }

  void _submit() {
    Navigator.pop(
      context,
      MigraineObservationInput(
        timestamp: _timestamp,
        intensity: _intensity,
        laterality: _laterality,
        location: _location,
        aura: _aura.value,
        nausea: _nausea.value,
        photophobia: _photophobia.value,
        phonophobia: _phonophobia.value,
        note: _note,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    return AlertDialog(
      title: Text(
        widget.observation == null
            ? s.addMigraineObservationAction
            : s.editMigraineObservationTitle,
      ),
      content: SizedBox(
        width: 480,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.observationTimeLabel),
              gapH8,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(DateFormat.yMMMd(locale).format(_timestamp)),
                    ),
                  ),
                  gapW8,
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickTime,
                      icon: const Icon(Icons.schedule),
                      label: Text(DateFormat.Hm(locale).format(_timestamp)),
                    ),
                  ),
                ],
              ),
              gapH16,
              Text(s.intensityLabel),
              gapH8,
              Wrap(
                spacing: Sizes.p8,
                runSpacing: Sizes.p8,
                children: [
                  for (var value = 0; value <= 10; value++)
                    ChoiceChip(
                      label: Text('$value'),
                      selected: _intensity == value,
                      onSelected: (_) => setState(() => _intensity = value),
                    ),
                ],
              ),
              gapH16,
              DropdownButtonFormField<String>(
                initialValue: _laterality?.name ?? '',
                decoration: InputDecoration(
                  labelText: s.migraineLateralityLabel,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: '', child: Text(s.presenceUnknown)),
                  for (final value in MigraineLaterality.values)
                    DropdownMenuItem(
                      value: value.name,
                      child: Text(_lateralityLabel(s, value)),
                    ),
                ],
                onChanged: (value) => setState(
                  () => _laterality = value == null || value.isEmpty
                      ? null
                      : MigraineLaterality.values.byName(value),
                ),
              ),
              gapH16,
              DropdownButtonFormField<String>(
                initialValue: _location?.name ?? '',
                decoration: InputDecoration(
                  labelText: s.migraineLocationLabel,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: '', child: Text(s.presenceUnknown)),
                  for (final value in MigraineLocation.values)
                    DropdownMenuItem(
                      value: value.name,
                      child: Text(_locationLabel(s, value)),
                    ),
                ],
                onChanged: (value) => setState(
                  () => _location = value == null || value.isEmpty
                      ? null
                      : MigraineLocation.values.byName(value),
                ),
              ),
              gapH16,
              _PresenceField(
                label: s.auraLabel,
                value: _aura,
                onChanged: (value) => setState(() => _aura = value),
              ),
              gapH12,
              _PresenceField(
                label: s.nauseaLabel,
                value: _nausea,
                onChanged: (value) => setState(() => _nausea = value),
              ),
              gapH12,
              _PresenceField(
                label: s.photophobiaLabel,
                value: _photophobia,
                onChanged: (value) => setState(() => _photophobia = value),
              ),
              gapH12,
              _PresenceField(
                label: s.phonophobiaLabel,
                value: _phonophobia,
                onChanged: (value) => setState(() => _phonophobia = value),
              ),
              gapH16,
              TextFormField(
                initialValue: _note,
                decoration: InputDecoration(
                  labelText: s.noteHint,
                  border: const OutlineInputBorder(),
                ),
                minLines: 2,
                maxLines: 4,
                onChanged: (value) => _note = value,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(s.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(s.save)),
      ],
    );
  }
}

class _PresenceField extends StatelessWidget {
  const _PresenceField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final _Presence value;
  final ValueChanged<_Presence> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        gapH8,
        SegmentedButton<_Presence>(
          segments: [
            ButtonSegment(
              value: _Presence.unknown,
              label: Text(s.presenceUnknown),
            ),
            ButtonSegment(
              value: _Presence.absent,
              label: Text(s.presenceAbsent),
            ),
            ButtonSegment(
              value: _Presence.present,
              label: Text(s.presencePresent),
            ),
          ],
          selected: {value},
          onSelectionChanged: (values) => onChanged(values.first),
        ),
      ],
    );
  }
}

enum _Presence {
  unknown(value: null),
  absent(value: false),
  present(value: true);

  const _Presence({required this.value});

  factory _Presence.fromValue({required bool? value}) => switch (value) {
    true => present,
    false => absent,
    null => unknown,
  };

  final bool? value;
}

String _lateralityLabel(AppStrings s, MigraineLaterality value) =>
    switch (value) {
      MigraineLaterality.left => s.migraineLateralityLeft,
      MigraineLaterality.right => s.migraineLateralityRight,
      MigraineLaterality.bilateral => s.migraineLateralityBilateral,
    };

String _locationLabel(AppStrings s, MigraineLocation value) => switch (value) {
  MigraineLocation.forehead => s.migraineLocationForehead,
  MigraineLocation.temple => s.migraineLocationTemple,
  MigraineLocation.eye => s.migraineLocationEye,
  MigraineLocation.backOfHead => s.migraineLocationBackOfHead,
  MigraineLocation.neck => s.migraineLocationNeck,
  MigraineLocation.diffuse => s.migraineLocationDiffuse,
};
