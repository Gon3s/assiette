import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:assiette/features/favorites/presentation/favorites_providers.dart';
import 'package:assiette/features/notifications/data/notifications_service.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Horizontal row of favorite meals (templates): a tap instantly logs a
/// meal copying the template's tags, with no intermediate screen.
class FavoritesRow extends ConsumerWidget {
  /// Creates a [FavoritesRow].
  const FavoritesRow({super.key});

  Future<void> _logFavorite(
    BuildContext context,
    WidgetRef ref,
    MealTemplateOption template,
  ) async {
    final s = AppStrings.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final mealId = await ref
          .read(favoritesRepositoryProvider)
          .logFavorite(template);
      // Requested here, in the foreground, right after the user's first
      // meal log - the earliest moment the reminders being permitted
      // becomes actually useful to them.
      await LocalNotificationsService().requestPermission();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(s.favoriteMealAdded),
            action: SnackBarAction(
              label: s.undoAction,
              onPressed: () =>
                  ref.read(favoritesRepositoryProvider).undoLogFavorite(mealId),
            ),
          ),
        );
    } on Exception {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteTemplatesProvider).value ?? const [];
    if (favorites.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: Sizes.p48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        itemCount: favorites.length,
        separatorBuilder: (context, index) => gapW8,
        itemBuilder: (context, index) {
          final template = favorites[index];
          return Center(
            child: ActionChip(
              avatar: const Icon(Icons.star, size: Sizes.p16),
              label: Text(template.name),
              onPressed: () => _logFavorite(context, ref, template),
            ),
          );
        },
      ),
    );
  }
}
