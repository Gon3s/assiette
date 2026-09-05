import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/symptom_entry/domain/migraine_observation.dart';
import 'package:assiette/features/symptom_entry/domain/migraine_observation_repository.dart';
import 'package:assiette/features/symptom_entry/presentation/widgets/migraine_observation_dialog.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Reactive history of observations attached to one migraine episode.
class MigraineObservationsSection extends ConsumerWidget {
  /// Creates the observation history.
  const MigraineObservationsSection({
    required this.migraineId,
    super.key,
  });

  /// Parent migraine id.
  final String migraineId;

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final input = await showDialog<MigraineObservationInput>(
      context: context,
      builder: (context) => const MigraineObservationDialog(),
    );
    if (input == null) return;
    await ref
        .read(migraineObservationRepositoryProvider)
        .addObservation(migraineId, input);
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    MigraineObservation observation,
  ) async {
    final input = await showDialog<MigraineObservationInput>(
      context: context,
      builder: (context) => MigraineObservationDialog(
        observation: observation,
      ),
    );
    if (input == null) return;
    await ref
        .read(migraineObservationRepositoryProvider)
        .updateObservation(observation.id, input);
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    MigraineObservation observation,
  ) async {
    final repository = ref.read(migraineObservationRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    await repository.deleteObservation(observation.id);
    if (!context.mounted) return;
    final s = AppStrings.of(context);
    messenger.showSnackBar(
      SnackBar(
        content: Text(s.observationDeleted),
        action: SnackBarAction(
          label: s.undoAction,
          onPressed: () => repository.undoDeleteObservation(observation.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final observations = ref.watch(migraineObservationsProvider(migraineId));
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                s.migraineObservationsTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TextButton.icon(
              onPressed: () => _add(context, ref),
              icon: const Icon(Icons.add),
              label: Text(s.addMigraineObservationAction),
            ),
          ],
        ),
        observations.when(
          data: (items) => Column(
            children: [
              for (final observation in items)
                ListTile(
                  key: ValueKey(observation.id),
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    child: Text('${observation.intensity}'),
                  ),
                  title: Text(
                    DateFormat.yMMMd(
                      locale,
                    ).add_Hm().format(observation.timestamp.toLocal()),
                  ),
                  subtitle: observation.note == null
                      ? null
                      : Text(
                          observation.note!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                  onTap: () => _edit(context, ref, observation),
                  trailing: IconButton(
                    tooltip: s.deleteAction,
                    onPressed: () => _delete(context, ref, observation),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ),
            ],
          ),
          loading: () => const Padding(
            padding: EdgeInsets.all(Sizes.p16),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, _) => Text(s.errorGeneric),
        ),
      ],
    );
  }
}
