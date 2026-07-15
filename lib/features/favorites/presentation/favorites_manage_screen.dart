import 'dart:io';

import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:assiette/features/favorites/presentation/favorites_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/enum_labels.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Favorites management screen: list, create, edit and delete favorites
/// (meal templates).
class FavoritesManageScreen extends ConsumerWidget {
  /// Creates a [FavoritesManageScreen].
  const FavoritesManageScreen({super.key});

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    MealTemplateOption favorite,
  ) async {
    final s = AppStrings.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(s.deleteFavoriteConfirmTitle),
        content: Text(s.deleteFavoriteConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(s.confirm),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(favoritesRepositoryProvider).deleteFavorite(favorite.id);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.favoriteDeleted)));
    } on Exception {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final favorites = ref.watch(favoriteTemplatesProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: Text(s.favoritesManageTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppRouter.favoriteForm.name),
        child: const Icon(Icons.add),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                s.noFavoritesMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                final subtitleParts = [
                  if (favorite.defaultMealType != null)
                    mealTypeLabel(s, favorite.defaultMealType!),
                  if (favorite.tags.isNotEmpty)
                    favorite.tags.map((tag) => tag.label).join(', '),
                ];
                return ListTile(
                  leading: favorite.defaultPhotoPath == null
                      ? const CircleAvatar(child: Icon(Icons.star))
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(favorite.defaultPhotoPath!),
                          ),
                        ),
                  title: Text(favorite.name),
                  subtitle: subtitleParts.isEmpty
                      ? null
                      : Text(subtitleParts.join(' · ')),
                  onTap: () => context.pushNamed(
                    AppRouter.favoriteForm.name,
                    queryParameters: {'id': favorite.id},
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: s.deleteAction,
                    onPressed: () => _confirmDelete(context, ref, favorite),
                  ),
                );
              },
            ),
    );
  }
}
