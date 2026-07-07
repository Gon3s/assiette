import 'dart:io';

import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:assiette/features/day_view/presentation/widgets/timeline_labels.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A single timeline row: a meal (photo thumbnail + tag chips) or a
/// symptom (colored dot + intensity).
class TimelineTile extends StatelessWidget {
  /// Creates a [TimelineTile] for the given [item].
  const TimelineTile({required this.item, super.key});

  /// The timeline entry to render.
  final TimelineItem item;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final time =
        DateFormat.Hm(locale).format(item.timestamp.toLocal());

    return switch (item) {
      MealTimelineItem(:final mealType, :final tagLabels, :final photoPath) =>
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
        ),
      SymptomTimelineItem(
        :final symptomType,
        :final intensity,
        :final detail,
      ) =>
        ListTile(
          leading: CircleAvatar(
            radius: Sizes.p12,
            backgroundColor: symptomTypeColor(symptomType),
            child: Text(
              '$intensity',
              style: const TextStyle(
                color: Colors.white,
                fontSize: Sizes.p12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(symptomTypeLabel(s, symptomType)),
          subtitle: detail == null ? null : Text(detail),
          trailing: Text(time),
        ),
    };
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
