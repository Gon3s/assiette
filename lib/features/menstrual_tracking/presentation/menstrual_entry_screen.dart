import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:assiette/features/menstrual_tracking/presentation/menstrual_providers.dart';
import 'package:assiette/features/menstrual_tracking/presentation/menstrual_settings_screen.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/menstrual_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MenstrualEntryScreen extends ConsumerWidget {
  const MenstrualEntryScreen({required this.date, super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final key = menstrualDateKey(date);
    final preferences = ref.watch(menstrualPreferencesProvider);
    final observation = ref.watch(menstrualDayProvider(key));
    return Scaffold(
      appBar: AppBar(title: Text(s.menstrualTitle)),
      body: preferences.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(s.errorGeneric)),
        data: (prefs) {
          if (!prefs.enabled) {
            return Center(child: Text(s.menstrualPrivacyNotice));
          }
          if (key.compareTo(menstrualDateKey(DateTime.now())) > 0) {
            return Center(child: Text(s.menstrualFutureDate));
          }
          return observation.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => Center(
              child: TextButton(
                onPressed: () => ref.invalidate(menstrualDayProvider(key)),
                child: Text(s.retryAction),
              ),
            ),
            data: (value) => _MenstrualForm(
              key: ValueKey(key),
              date: date,
              initial: value,
            ),
          );
        },
      ),
    );
  }
}

class _MenstrualForm extends ConsumerStatefulWidget {
  const _MenstrualForm({required this.date, required this.initial, super.key});

  final DateTime date;
  final MenstrualObservation? initial;

  @override
  ConsumerState<_MenstrualForm> createState() => _MenstrualFormState();
}

class _MenstrualFormState extends ConsumerState<_MenstrualForm> {
  BleedingStatus? _status;
  MenstrualFlow? _flow;
  bool _start = false;
  late final TextEditingController _note;

  @override
  void initState() {
    super.initState();
    _status = widget.initial?.status;
    _flow = widget.initial?.flow;
    _start = widget.initial?.isPeriodStart ?? false;
    _note = TextEditingController(text: widget.initial?.note ?? '');
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final actions = ref.watch(menstrualActionsProvider);
    final notifier = ref.read(menstrualActionsProvider.notifier);
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    return ListView(
      padding: const EdgeInsets.all(Sizes.p16),
      children: [
        Text(DateFormat.yMMMMEEEEd(locale).format(widget.date)),
        gapH16,
        Wrap(
          spacing: Sizes.p8,
          children: [
            for (final status in BleedingStatus.values)
              ChoiceChip(
                label: Text(bleedingStatusLabel(s, status)),
                selected: _status == status,
                onSelected: actions.isLoading
                    ? null
                    : (_) => setState(() {
                        _status = status;
                        if (status != BleedingStatus.period) {
                          _flow = null;
                          _start = false;
                        }
                      }),
              ),
          ],
        ),
        if (_status == BleedingStatus.period) ...[
          gapH16,
          Text(s.menstrualFlow),
          Wrap(
            spacing: Sizes.p8,
            children: [
              for (final flow in [null, ...MenstrualFlow.values])
                ChoiceChip(
                  label: Text(menstrualFlowLabel(s, flow)),
                  selected: _flow == flow,
                  onSelected: actions.isLoading
                      ? null
                      : (_) => setState(() => _flow = flow),
                ),
            ],
          ),
          CheckboxListTile(
            title: Text(s.menstrualStart),
            value: _start,
            onChanged: actions.isLoading
                ? null
                : (value) => setState(() => _start = value ?? false),
          ),
          Text(s.menstrualChangeStatusNotice),
        ],
        gapH16,
        TextField(
          controller: _note,
          enabled: !actions.isLoading,
          maxLength: 2000,
          maxLines: 4,
          decoration: InputDecoration(labelText: s.noteHint),
        ),
        gapH16,
        FilledButton(
          onPressed: actions.isLoading || _status == null
              ? null
              : () async {
                  final ok = await notifier.save(
                    MenstrualObservation(
                      localDate: menstrualDateKey(widget.date),
                      status: _status!,
                      flow: _flow,
                      isPeriodStart: _start,
                      note: _note.text,
                    ),
                  );
                  if (ok && context.mounted) context.pop();
                },
          child: Text(s.save),
        ),
        if (widget.initial != null)
          TextButton(
            onPressed: actions.isLoading
                ? null
                : () async {
                    final confirmed = await confirmMenstrualAction(
                      context,
                      title: s.menstrualDeleteTitle,
                      body: s.menstrualDeleteBody,
                    );
                    if (!confirmed) return;
                    final ok = await notifier.delete(
                      menstrualDateKey(widget.date),
                    );
                    if (ok && context.mounted) context.pop();
                  },
            child: Text(s.deleteAction),
          ),
        if (actions.hasError) Text(s.errorGeneric),
      ],
    );
  }
}
