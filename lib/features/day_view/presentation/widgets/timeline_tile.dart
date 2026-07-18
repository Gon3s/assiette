import 'dart:io';

import 'package:assiette/constants/app_colors.dart';
import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:assiette/features/day_view/presentation/widgets/timeline_labels.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/enum_labels.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// A single timeline row: a meal (photo thumbnail + tag chips) or a
/// symptom (colored dot + intensity). Tapping opens the entry for
/// editing (US-12).
class TimelineTile extends ConsumerWidget {
  /// Creates a [TimelineTile] for the given [item].
  const TimelineTile({required this.item, super.key});

  /// The timeline entry to render.
  final TimelineItem item;

  Future<void> _openMeal(BuildContext context, WidgetRef ref, String id) async {
    final draft = await ref.read(mealEntryRepositoryProvider).loadMeal(id);
    if (draft == null || !context.mounted) return;
    await context.pushNamed(AppRouter.mealEntry.name, extra: draft);
  }

  Future<void> _openSymptom(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final draft =
        await ref.read(symptomEntryRepositoryProvider).loadSymptom(id);
    if (draft == null || !context.mounted) return;
    await context.pushNamed(AppRouter.symptomEntry.name, extra: draft);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final time =
        DateFormat.Hm(locale).format(item.timestamp.toLocal());

    return switch (item) {
      MealTimelineItem(
        :final id,
        :final mealType,
        :final tagLabels,
        :final photoPath,
      ) =>
        ListTile(
          leading: _MealThumbnail(photoPath: photoPath),
          title: Text(mealTypeLabel(s, mealType)),
          subtitle: tagLabels.isEmpty
              ? null
              : Wrap(
                  spacing: Sizes.p4,
                  runSpacing: Sizes.p4,
                  children: [
                    for (final label in tagLabels)
                      Chip(
                        label: Text(label),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ),
                  ],
                ),
          trailing: Text(time),
          onTap: () => _openMeal(context, ref, id),
        ),
      SymptomTimelineItem(
        :final id,
        :final symptomType,
        :final intensity,
        :final detail,
      ) =>
        ListTile(
          leading: _SymptomBadge(
            color: symptomTypeColor(symptomType),
            intensity: intensity,
          ),
          title: Text(symptomTypeLabel(s, symptomType)),
          subtitle: detail == null ? null : Text(detail),
          trailing: Text(time),
          onTap: () => _openSymptom(context, ref, id),
        ),
    };
  }
}

class _SymptomBadge extends StatelessWidget {
  const _SymptomBadge({required this.color, required this.intensity});

  final Color color;
  final int intensity;

  @override
  Widget build(BuildContext context) {
    // Dark navy text on light accents (yellow), white on dark ones.
    final onColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.light
            ? AppColors.background
            : Colors.white;
    return CircleAvatar(
      radius: Sizes.p12,
      backgroundColor: color,
      child: Text(
        '$intensity',
        style: TextStyle(
          color: onColor,
          fontSize: Sizes.p12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _MealThumbnail extends StatelessWidget {
  const _MealThumbnail({this.photoPath});

  final String? photoPath;

  @override
  Widget build(BuildContext context) {
    final path = photoPath;
    if (path == null) {
      return const CircleAvatar(
        radius: Sizes.p20,
        child: Icon(Icons.restaurant),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.p8),
      child: Image.file(
        File(path),
        width: Sizes.p48,
        height: Sizes.p48,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const CircleAvatar(
          radius: Sizes.p20,
          child: Icon(Icons.restaurant),
        ),
      ),
    );
  }
}
