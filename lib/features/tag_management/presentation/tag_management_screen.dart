import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/tag_management/domain/managed_tag.dart';
import 'package:assiette/features/tag_management/presentation/tag_management_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/utils/tag_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum _TagAction { rename, delete }

class TagManagementScreen extends ConsumerStatefulWidget {
  const TagManagementScreen({super.key});

  @override
  ConsumerState<TagManagementScreen> createState() =>
      _TagManagementScreenState();
}

class _TagManagementScreenState extends ConsumerState<TagManagementScreen> {
  String _query = '';

  Future<void> _rename(ManagedTag tag) => showDialog<void>(
    context: context,
    builder: (_) => _RenameTagDialog(tag: tag),
  );

  Future<void> _delete(ManagedTag tag) async {
    final s = AppStrings.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(s.deleteTagTitle(tag.label)),
        content: Text(
          s.deleteTagMessage(tag.dayCount, tag.mealCount, tag.favoriteCount),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(s.deleteAction),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final success = await ref
        .read(tagManagementControllerProvider.notifier)
        .deleteTag(tag.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? s.tagDeleted : s.errorGeneric)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final tags = ref.watch(managedTagsProvider);
    final busy = ref.watch(tagManagementControllerProvider).isLoading;
    return Scaffold(
      appBar: AppBar(title: Text(s.manageTagsAction)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: TextField(
              decoration: InputDecoration(
                hintText: s.manageTagsSearchHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          Expanded(
            child: tags.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(s.errorGeneric),
                    TextButton(
                      onPressed: () => ref.invalidate(managedTagsProvider),
                      child: Text(s.retryAction),
                    ),
                  ],
                ),
              ),
              data: (all) {
                final query = normalizeTagLabel(_query).toLowerCase();
                final filtered = all
                    .where(
                      (tag) => tag.label.toLowerCase().contains(query),
                    )
                    .toList();
                if (filtered.isEmpty) {
                  return Center(
                    child: Text(all.isEmpty ? s.noTagsMessage : s.noTagsFound),
                  );
                }
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final tag = filtered[index];
                    return ListTile(
                      key: ValueKey(tag.id),
                      leading: Icon(
                        tag.isSystem ? Icons.label : Icons.label_outline,
                      ),
                      title: Text(tag.label),
                      subtitle: Text(
                        [
                          _categoryLabel(s, tag.category),
                          s.tagUsageDays(tag.dayCount),
                          if (tag.isSystem) s.systemTagLabel,
                        ].join(' · '),
                      ),
                      onTap: busy ? null : () => _rename(tag),
                      trailing: PopupMenuButton<_TagAction>(
                        enabled: !busy,
                        tooltip: s.tagActions,
                        onSelected: (action) async {
                          switch (action) {
                            case _TagAction.rename:
                              await _rename(tag);
                            case _TagAction.delete:
                              await _delete(tag);
                          }
                        },
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            value: _TagAction.rename,
                            child: Text(s.renameTagAction),
                          ),
                          PopupMenuItem(
                            value: _TagAction.delete,
                            child: Text(s.deleteAction),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _categoryLabel(AppStrings s, String? category) => switch (category) {
    'alimentation' => s.tagCategoryFood,
    'mode_de_vie' => s.tagCategoryLifestyle,
    'environnement' => s.tagCategoryEnvironment,
    'médical' => s.tagCategoryMedical,
    null || '' => s.tagCategoryOther,
    _ => category,
  };
}

class _RenameTagDialog extends ConsumerStatefulWidget {
  const _RenameTagDialog({required this.tag});

  final ManagedTag tag;

  @override
  ConsumerState<_RenameTagDialog> createState() => _RenameTagDialogState();
}

class _RenameTagDialogState extends ConsumerState<_RenameTagDialog> {
  late final _label = TextEditingController(text: widget.tag.label);
  String? _error;

  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final success = await ref
        .read(tagManagementControllerProvider.notifier)
        .renameTag(widget.tag.id, _label.text);
    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop();
      return;
    }
    final s = AppStrings.of(context);
    final error = ref.read(tagManagementControllerProvider).error;
    setState(() {
      _error = switch (error) {
        TagLabelException(reason: TagLabelError.empty) => s.tagLabelRequired,
        TagLabelException(reason: TagLabelError.duplicate) =>
          s.tagLabelDuplicate,
        _ => s.errorGeneric,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final busy = ref.watch(tagManagementControllerProvider).isLoading;
    return PopScope(
      canPop: !busy,
      child: AlertDialog(
        title: Text(s.renameTagAction),
        content: TextField(
          controller: _label,
          autofocus: true,
          enabled: !busy,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: s.tagLabelField,
            errorText: _error,
          ),
          onSubmitted: busy ? null : (_) => _save(),
        ),
        actions: [
          TextButton(
            onPressed: busy ? null : () => Navigator.of(context).pop(),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: busy ? null : _save,
            child: Text(s.save),
          ),
        ],
      ),
    );
  }
}
