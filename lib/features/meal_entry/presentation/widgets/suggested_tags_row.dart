import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Candidate tags suggested from the meal photo (US-19). Never applied
/// automatically: the user taps a chip to accept it, or dismisses it.
class SuggestedTagsRow extends ConsumerWidget {
  /// Creates a [SuggestedTagsRow].
  const SuggestedTagsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final isSuggesting = ref.watch(
      mealEntryControllerProvider.select((state) => state.isSuggestingTags),
    );
    final suggestions = ref.watch(
      mealEntryControllerProvider.select((state) => state.suggestedTagLabels),
    );
    final controller = ref.read(mealEntryControllerProvider.notifier);

    if (!isSuggesting && suggestions.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: Sizes.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.suggestedTagsLabel,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          gapH4,
          if (isSuggesting)
            const SizedBox(
              height: Sizes.p20,
              width: Sizes.p20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Wrap(
              spacing: Sizes.p8,
              runSpacing: Sizes.p4,
              children: [
                for (final label in suggestions)
                  InputChip(
                    avatar: const Icon(Icons.auto_awesome, size: Sizes.p16),
                    label: Text(label),
                    onPressed: () => controller.acceptSuggestedTag(label),
                    onDeleted: () => controller.dismissSuggestedTag(label),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
