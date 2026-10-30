import 'dart:async';

import 'package:assiette/features/coffee/domain/coffee_repository.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:assiette/features/favorites/domain/quick_favorite_repository.dart';
import 'package:assiette/features/favorites/presentation/quick_favorite_picker.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class QuickActionScreen extends ConsumerStatefulWidget {
  const QuickActionScreen({super.key});

  @override
  ConsumerState<QuickActionScreen> createState() => _QuickActionScreenState();
}

class _QuickActionScreenState extends ConsumerState<QuickActionScreen> {
  bool _running = false;
  bool _failed = false;
  bool _choosing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(_run()));
  }

  Future<void> _run() async {
    if (_running) return;
    _running = true;
    try {
      final s = AppStrings.of(context);
      final coffeeRepository = ref.read(coffeeRepositoryProvider);
      final favoritesRepository = ref.read(favoritesRepositoryProvider);
      final selection =
          await ref.read(quickFavoriteSelectionProvider.future) ??
          coffeeQuickFavoriteId;
      if (!mounted) return;
      final favorites = selection == coffeeQuickFavoriteId
          ? <MealTemplateOption>[]
          : await favoritesRepository.watchFavorites().first;
      if (!mounted) return;
      if (selection != coffeeQuickFavoriteId &&
          !favorites.any((template) => template.id == selection)) {
        setState(() => _choosing = true);
        await pickQuickFavorite(context, ref);
        // Choosing configures the next invocation; it never logs a surprise entry.
        if (mounted) context.goNamed(AppRouter.settings.name);
        return;
      }
      final isCoffee = selection == coffeeQuickFavoriteId;
      final id = isCoffee
          ? await coffeeRepository.add(DateTime.now())
          : await favoritesRepository.logFavorite(
              favorites.firstWhere((template) => template.id == selection),
            );
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      ref.read(selectedDateProvider.notifier).goToToday();
      context.goNamed(AppRouter.home.name);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(isCoffee ? s.coffeeAdded : s.favoriteMealAdded),
            action: SnackBarAction(
              label: s.undoAction,
              onPressed: () => isCoffee
                  ? coffeeRepository.setDeleted(id, deleted: true)
                  : favoritesRepository.undoLogFavorite(id),
            ),
          ),
        );
    } on Exception {
      if (mounted) {
        setState(() {
          _choosing = false;
          _failed = true;
        });
      }
    } finally {
      _running = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(quickFavoriteSelectionProvider);
    final s = AppStrings.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.quickFavoriteTitle),
      ),
      body: Center(
        child: _failed
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(s.errorGeneric),
                  FilledButton(
                    onPressed: () {
                      setState(() => _failed = false);
                      unawaited(_run());
                    },
                    child: Text(s.retryAction),
                  ),
                ],
              )
            : _choosing
            ? const SizedBox.shrink()
            : const CircularProgressIndicator(),
      ),
    );
  }
}
