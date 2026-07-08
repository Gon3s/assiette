import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Selected-tags chips + a search field suggesting existing tags or
/// creating a new one on the fly.
class TagSelector extends ConsumerStatefulWidget {
  /// Creates a [TagSelector].
  const TagSelector({super.key});

  @override
  ConsumerState<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends ConsumerState<TagSelector> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSelected(TagOption tag) {
    ref.read(mealEntryControllerProvider.notifier).addTag(tag);
    _searchController.clear();
    setState(() => _query = '');
  }

  Future<void> _onCreate(String label) async {
    await ref
        .read(mealEntryControllerProvider.notifier)
        .createAndAddTag(label);
    _searchController.clear();
    setState(() => _query = '');
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final selected = ref.watch(
      mealEntryControllerProvider.select((state) => state.selectedTags),
    );
    final allTags = ref.watch(availableTagsProvider).value ?? [];

    final query = _query.trim().toLowerCase();
    final suggestions = query.isEmpty
        ? const <TagOption>[]
        : allTags
            .where(
              (tag) =>
                  tag.label.toLowerCase().contains(query) &&
                  !selected.any((t) => t.id == tag.id),
            )
            .take(6)
            .toList();
    final exactMatch =
        allTags.any((tag) => tag.label.toLowerCase() == query);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selected.isNotEmpty) ...[
          Wrap(
            spacing: Sizes.p8,
            runSpacing: Sizes.p4,
            children: [
              for (final tag in selected)
                InputChip(
                  label: Text(tag.label),
                  onDeleted: () => ref
                      .read(mealEntryControllerProvider.notifier)
                      .removeTag(tag),
                ),
            ],
          ),
          gapH8,
        ],
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: s.tagSearchHint,
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(),
            isDense: true,
          ),
          onChanged: (value) => setState(() => _query = value),
        ),
        if (query.isNotEmpty) ...[
          gapH4,
          for (final tag in suggestions)
            ListTile(
              dense: true,
              leading: const Icon(Icons.label_outline),
              title: Text(tag.label),
              onTap: () => _onSelected(tag),
            ),
          if (!exactMatch)
            ListTile(
              dense: true,
              leading: const Icon(Icons.add),
              title: Text(s.createTagLabel(_query.trim())),
              onTap: () => _onCreate(_query),
            ),
        ],
      ],
    );
  }
}
