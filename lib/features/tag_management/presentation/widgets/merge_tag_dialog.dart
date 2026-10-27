import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/tag_management/domain/managed_tag.dart';
import 'package:assiette/features/tag_management/presentation/tag_management_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/utils/tag_merge_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MergeTagDialog extends ConsumerStatefulWidget {
  const MergeTagDialog({required this.sourceId, super.key});

  final String sourceId;

  @override
  ConsumerState<MergeTagDialog> createState() => _MergeTagDialogState();
}

class _MergeTagDialogState extends ConsumerState<MergeTagDialog> {
  String? _targetId;
  bool _failed = false;

  Future<void> _merge(String targetId) async {
    final success = await ref
        .read(tagManagementControllerProvider.notifier)
        .mergeTags(widget.sourceId, targetId);
    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop(true);
    } else {
      setState(() => _failed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final tags = ref.watch(managedTagsProvider);
    final busy = ref.watch(tagManagementControllerProvider).isLoading;
    final all = tags.asData?.value ?? const <ManagedTag>[];
    final source = all.where((tag) => tag.id == widget.sourceId).firstOrNull;
    final targets = all.where((tag) => tag.id != widget.sourceId).toList();
    final target = targets.where((tag) => tag.id == _targetId).firstOrNull;
    final preview = source != null && target != null
        ? ref.watch(tagMergePreviewProvider(source.id, target.id))
        : null;
    final ready =
        preview?.hasValue == true &&
        preview?.isLoading == false &&
        preview?.hasError == false;

    return PopScope(
      canPop: !busy,
      child: AlertDialog(
        title: Text(s.mergeTagsAction),
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (tags.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (tags.hasError || source == null)
              Text(s.tagMergeUnavailable)
            else ...[
              Text(s.tagMergeSourceLabel),
              _TagUsage(tag: source),
              gapH16,
              if (targets.isEmpty)
                Text(s.tagMergeNoTarget)
              else
                DropdownButtonFormField<String>(
                  key: ValueKey(target?.id),
                  initialValue: target?.id,
                  isExpanded: true,
                  decoration: InputDecoration(labelText: s.tagMergeTargetLabel),
                  items: [
                    for (final candidate in targets)
                      DropdownMenuItem(
                        value: candidate.id,
                        child: Text(
                          candidate.label,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: busy
                      ? null
                      : (id) => setState(() {
                          _targetId = id;
                          _failed = false;
                        }),
                ),
              if (preview != null) ...[
                gapH16,
                preview.when(
                  skipLoadingOnRefresh: false,
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.tagMergeUnavailable),
                      TextButton(
                        onPressed: busy
                            ? null
                            : () => ref.invalidate(
                                tagMergePreviewProvider(source.id, target!.id),
                              ),
                        child: Text(s.retryAction),
                      ),
                    ],
                  ),
                  data: (value) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TagUsage(tag: value.target),
                      gapH16,
                      Text(
                        s.tagMergeAffectedFavorites(value.favoriteNames.length),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      gapH8,
                      Text(
                        value.favoriteNames.isEmpty
                            ? s.tagMergeNoFavorites
                            : value.favoriteNames.join(', '),
                      ),
                      gapH16,
                      Text(
                        s.tagMergeMessage(
                          value.source.label,
                          value.target.label,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
            if (_failed) ...[
              gapH16,
              Text(
                ref.read(tagManagementControllerProvider).error
                        is TagMergeException
                    ? s.tagMergeUnavailable
                    : s.errorGeneric,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: busy ? null : () => Navigator.of(context).pop(false),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: !busy && ready && target != null
                ? () => _merge(target.id)
                : null,
            child: Text(s.mergeTagsAction),
          ),
        ],
      ),
    );
  }
}

class _TagUsage extends StatelessWidget {
  const _TagUsage({required this.tag});

  final ManagedTag tag;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(tag.label),
      subtitle: Text(
        [
          s.tagUsageDays(tag.dayCount),
          s.tagMergeFavoriteCount(tag.favoriteCount),
        ].join(' · '),
      ),
    );
  }
}
