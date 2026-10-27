import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/features/migraine_history/domain/migraine_history_entry.dart';
import 'package:assiette/features/migraine_history/presentation/migraine_history_controller.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MigraineHistoryScreen extends ConsumerWidget {
  const MigraineHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final history = ref.watch(migraineHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: Text(s.migraineHistoryTitle)),
      body: history.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(s.migraineHistoryLoadError, textAlign: TextAlign.center),
                gapH16,
                FilledButton(
                  onPressed: () => ref.invalidate(migraineHistoryProvider),
                  child: Text(s.retryAction),
                ),
              ],
            ),
          ),
        ),
        data: (entries) => entries.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p32),
                  child: Text(
                    s.migraineHistoryEmpty,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : ListView.builder(
                key: const PageStorageKey('migraine-history'),
                padding: const EdgeInsets.all(Sizes.p16),
                itemCount: entries.length,
                findChildIndexCallback: (key) {
                  if (key is! ValueKey<String>) return null;
                  final index = entries.indexWhere(
                    (entry) => entry.migraine.id == key.value,
                  );
                  return index < 0 ? null : index;
                },
                itemBuilder: (context, index) => _MigraineCard(
                  key: ValueKey(entries[index].migraine.id),
                  entry: entries[index],
                ),
              ),
      ),
    );
  }
}

class _MigraineCard extends StatelessWidget {
  const _MigraineCard({required this.entry, super.key});

  final MigraineHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final migraine = entry.migraine;
    final end = migraine.endedAt ?? migraine.endTime;
    return Card(
      margin: const EdgeInsets.only(bottom: Sizes.p12),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        key: PageStorageKey(migraine.id),
        title: Text(
          end == null ? s.migraineHistoryOngoing : s.migraineHistoryEnded,
        ),
        leading: Icon(end == null ? Icons.bolt : Icons.history),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: Sizes.p4),
          child: Text(
            [
              _startLabel(context, migraine),
              if (end != null)
                s.migraineHistoryEnd(_formatDateTime(context, end)),
            ].join('\n'),
          ),
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.fromLTRB(
          Sizes.p16,
          0,
          Sizes.p16,
          Sizes.p16,
        ),
        children: [
          const Divider(),
          Text(
            s.medicationSectionTitle,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          gapH8,
          if (entry.intakes.isEmpty)
            Text(s.migraineHistoryNoIntakes)
          else
            for (final intake in entry.intakes)
              ListTile(
                key: ValueKey(intake.id),
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.medication_outlined),
                title: Text(intake.name),
                subtitle: Text(
                  [
                    if (intake.dose case final dose?)
                      if (dose.trim().isNotEmpty) dose,
                    _formatDateTime(context, intake.timestamp),
                  ].join(' · '),
                ),
              ),
          gapH8,
          OutlinedButton.icon(
            onPressed: () => context.pushNamed(
              AppRouter.symptomEntry.name,
              extra: migraine,
            ),
            icon: const Icon(Icons.edit_outlined),
            label: Text(s.migraineHistoryEdit),
          ),
        ],
      ),
    );
  }
}

String _startLabel(BuildContext context, SymptomDraft migraine) {
  final s = AppStrings.of(context);
  final start = migraine.startedAt;
  if (start == null ||
      migraine.startPrecision == MigraineStartPrecision.unknown) {
    final locale = Localizations.localeOf(context).toString();
    return [
      s.migraineHistoryStart(s.migraineStartUnknown),
      s.migraineHistoryRecordedOn(
        DateFormat.yMMMd(locale).format(migraine.timestamp.toLocal()),
      ),
    ].join('\n');
  }
  final dateTime = _formatDateTime(context, start);
  return migraine.startPrecision == MigraineStartPrecision.exact
      ? s.migraineHistoryStart(dateTime)
      : s.migraineHistoryApproximateStart(dateTime);
}

String _formatDateTime(BuildContext context, DateTime value) =>
    DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    ).add_Hm().format(value.toLocal());
