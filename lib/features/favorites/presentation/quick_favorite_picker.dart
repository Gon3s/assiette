import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/quick_favorite_repository.dart';
import 'package:assiette/features/favorites/presentation/favorites_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<String?> pickQuickFavorite(BuildContext context, WidgetRef ref) async {
  final s = AppStrings.of(context);
  final messenger = ScaffoldMessenger.of(context);
  try {
    final templates = await ref
        .read(favoritesRepositoryProvider)
        .watchFavorites()
        .first;
    if (!context.mounted) return null;
    final id = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text(s.quickFavoriteNone),
              subtitle: Text(s.quickFavoriteHint),
            ),
            ListTile(
              leading: const Icon(Icons.coffee_outlined),
              title: Text(s.coffeeTitle),
              onTap: () => Navigator.pop(context, coffeeQuickFavoriteId),
            ),
            for (final template in templates)
              ListTile(
                leading: const Icon(Icons.star_outline),
                title: Text(template.name),
                onTap: () => Navigator.pop(context, template.id),
              ),
          ],
        ),
      ),
    );
    if (id != null) await ref.read(quickFavoriteRepositoryProvider).select(id);
    return id;
  } on Exception {
    if (messenger.mounted) {
      messenger.showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
    return null;
  }
}

class QuickFavoriteSetting extends ConsumerWidget {
  const QuickFavoriteSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final selection = ref.watch(quickFavoriteSelectionProvider);
    final templates = ref.watch(favoriteTemplatesProvider).value ?? const [];
    var label = s.quickFavoriteNone;
    if (selection.value == coffeeQuickFavoriteId) label = s.coffeeTitle;
    for (final template in templates) {
      if (template.id == selection.value) label = template.name;
    }
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.touch_app_outlined),
      title: Text(s.quickFavoriteTitle),
      subtitle: Text(selection.hasError ? s.errorGeneric : label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => pickQuickFavorite(context, ref),
    );
  }
}
