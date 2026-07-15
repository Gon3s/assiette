import 'dart:io';

import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Photo capture area: a big camera button, or the preview with
/// retake/remove actions.
class PhotoSection extends ConsumerWidget {
  /// Creates a [PhotoSection].
  const PhotoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final photoPath = ref.watch(
      mealEntryControllerProvider.select((state) => state.photoPath),
    );
    final controller = ref.read(mealEntryControllerProvider.notifier);

    if (photoPath == null) {
      return OutlinedButton.icon(
        onPressed: controller.takePhoto,
        icon: const Icon(Icons.photo_camera),
        label: Text(s.takePhoto),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(Sizes.p64),
        ),
      );
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.p12),
          child: Image.file(
            File(photoPath),
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 180,
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Icon(Icons.broken_image),
            ),
          ),
        ),
        gapH8,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: controller.takePhoto,
              icon: const Icon(Icons.refresh),
              label: Text(s.retakePhoto),
            ),
            gapW16,
            TextButton.icon(
              onPressed: controller.removePhoto,
              icon: const Icon(Icons.delete_outline),
              label: Text(s.removePhoto),
            ),
          ],
        ),
      ],
    );
  }
}
