import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/presentation/favorite_form_controller.dart';
import 'package:assiette/features/favorites/presentation/widgets/favorite_photo_section.dart';
import 'package:assiette/features/favorites/presentation/widgets/favorite_tag_selector.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/enum_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Favorite create/edit form: name, default meal type, tags and photo.
class FavoriteFormScreen extends ConsumerWidget {
  /// Creates a [FavoriteFormScreen]. [templateId] is null when creating a
  /// new favorite.
  const FavoriteFormScreen({required this.templateId, super.key});

  /// The favorite being edited, or null when creating one.
  final String? templateId;

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final s = AppStrings.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      final saved = await ref
          .read(favoriteFormControllerProvider(templateId).notifier)
          .save();
      if (!saved) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              templateId == null ? s.favoriteSaved : s.favoriteUpdated,
            ),
          ),
        );
      router.pop();
    } on Exception {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final provider = favoriteFormControllerProvider(templateId);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          templateId == null ? s.newFavoriteTitle : s.editFavoriteTitle,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.p16),
        children: [
          TextFormField(
            initialValue: state.name,
            decoration: InputDecoration(
              labelText: s.favoriteNameTitle,
              hintText: s.favoriteNameHint,
              border: const OutlineInputBorder(),
            ),
            onChanged: notifier.setName,
          ),
          gapH16,
          FavoritePhotoSection(templateId: templateId),
          gapH16,
          Text(s.mealTypeLabel, style: Theme.of(context).textTheme.labelLarge),
          gapH8,
          SegmentedButton<MealType>(
            emptySelectionAllowed: true,
            segments: [
              for (final type in MealType.values)
                ButtonSegment(
                  value: type,
                  label: Text(
                    mealTypeLabel(s, type),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
            ],
            selected: {if (state.mealType != null) state.mealType!},
            onSelectionChanged: (selection) => notifier.setMealType(
              selection.isEmpty ? null : selection.first,
            ),
          ),
          gapH16,
          Text(s.tagsLabel, style: Theme.of(context).textTheme.labelLarge),
          gapH8,
          FavoriteTagSelector(templateId: templateId),
          gapH24,
          FilledButton(
            onPressed: state.isSaving ? null : () => _save(context, ref),
            child: state.isSaving
                ? const SizedBox(
                    height: Sizes.p20,
                    width: Sizes.p20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(s.save),
          ),
        ],
      ),
    );
  }
}
