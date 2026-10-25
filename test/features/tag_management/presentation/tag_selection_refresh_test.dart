import 'dart:async';

import 'package:assiette/features/favorites/presentation/favorite_form_controller.dart';
import 'package:assiette/features/favorites/presentation/widgets/favorite_tag_selector.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_controller.dart';
import 'package:assiette/features/meal_entry/presentation/widgets/tag_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final favorite in [false, true]) {
    testWidgets(
      'refreshes selected labels in ${favorite ? "favorites" : "meals"}',
      (tester) async {
        const tag = TagOption(id: 'tag', label: 'Old label', isSystem: false);
        final updates = StreamController<List<TagOption>>();
        final container = ProviderContainer(
          overrides: [
            availableTagsProvider.overrideWith((_) => updates.stream),
          ],
        );
      addTearDown(() async {
        container.dispose();
        await updates.close();
      });
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              home: Scaffold(
                body: favorite
                    ? const FavoriteTagSelector(templateId: null)
                    : const TagSelector(),
              ),
            ),
          ),
        );
        if (favorite) {
          container
              .read(favoriteFormControllerProvider(null).notifier)
              .addTag(tag);
        } else {
          container.read(mealEntryControllerProvider.notifier).addTag(tag);
        }
        updates.add([tag]);
        await tester.pumpAndSettle();
        expect(find.widgetWithText(InputChip, 'Old label'), findsOneWidget);
        updates.add([tag.copyWith(label: 'New label')]);
        await tester.pumpAndSettle();
        expect(find.widgetWithText(InputChip, 'New label'), findsOneWidget);
        expect(find.text('Old label'), findsNothing);
      },
    );
  }
}
