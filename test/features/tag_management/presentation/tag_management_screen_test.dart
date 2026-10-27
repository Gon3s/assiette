import 'dart:async';

import 'package:assiette/features/settings/presentation/settings_screen.dart';
import 'package:assiette/features/tag_management/domain/managed_tag.dart';
import 'package:assiette/features/tag_management/domain/tag_management_repository.dart';
import 'package:assiette/features/tag_management/domain/tag_merge_preview.dart';
import 'package:assiette/features/tag_management/presentation/tag_management_screen.dart';
import 'package:assiette/localization/strings_fr.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:assiette/utils/tag_labels.dart';
import 'package:assiette/utils/tag_merge_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockTagManagementRepository extends Mock
    implements TagManagementRepository {}

void main() {
  late MockTagManagementRepository repository;
  const coffee = ManagedTag(
    id: 'coffee',
    label: 'café',
    category: 'alimentation',
    isSystem: true,
    dayCount: 2,
    mealCount: 3,
    favoriteCount: 1,
  );
  const custom = ManagedTag(
    id: 'custom',
    label: 'Custom',
    isSystem: false,
    dayCount: 0,
    mealCount: 0,
    favoriteCount: 1,
  );

  setUp(() {
    repository = MockTagManagementRepository();
    when(repository.watchTags)
        .thenAnswer((_) => Stream.value([coffee, custom]));
  });

  Future<void> pumpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tagManagementRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(home: TagManagementScreen()),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> openDelete(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Tag actions').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
  }

  Future<void> openMerge(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Tag actions').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Merge tags'));
    await tester.pumpAndSettle();
  }

  Future<void> selectTarget(WidgetTester tester) async {
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(DropdownMenuItem<String>),
        matching: find.text('café'),
      ),
      findsNothing,
    );
    await tester.tap(find.text('Custom').last);
    await tester.pump();
  }

  const preview = TagMergePreview(
    source: coffee,
    target: custom,
    favoriteNames: ['Breakfast'],
  );

  testWidgets('merge waits for a target and preview, then can be cancelled', (
    tester,
  ) async {
    final pending = Completer<TagMergePreview>();
    when(() => repository.previewMerge('coffee', 'custom'))
        .thenAnswer((_) => pending.future);
    await pumpScreen(tester);
    await openMerge(tester);
    final confirm = find.widgetWithText(FilledButton, 'Merge tags');
    expect(tester.widget<FilledButton>(confirm).onPressed, isNull);
    await selectTarget(tester);
    expect(tester.widget<FilledButton>(confirm).onPressed, isNull);
    pending.complete(preview);
    await tester.pumpAndSettle();
    expect(find.text('2 days used · 1 favorite'), findsOneWidget);
    expect(find.text('0 days used · 1 favorite'), findsOneWidget);
    expect(find.text('Affected favorites (1)'), findsOneWidget);
    expect(find.text('Breakfast'), findsOneWidget);
    expect(tester.widget<FilledButton>(confirm).onPressed, isNotNull);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    verifyNever(() => repository.mergeTags(any(), any()));
  });

  testWidgets('confirmed merge blocks duplicate actions and refreshes tags', (
    tester,
  ) async {
    final pending = Completer<void>();
    final updates = StreamController<List<ManagedTag>>();
    addTearDown(updates.close);
    when(repository.watchTags).thenAnswer((_) => updates.stream);
    when(() => repository.previewMerge('coffee', 'custom'))
        .thenAnswer((_) async => preview);
    when(() => repository.mergeTags('coffee', 'custom'))
        .thenAnswer((_) => pending.future);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tagManagementRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(home: TagManagementScreen()),
      ),
    );
    updates.add([coffee, custom]);
    await tester.pumpAndSettle();
    await openMerge(tester);
    await selectTarget(tester);
    await tester.pumpAndSettle();
    final confirm = find.widgetWithText(FilledButton, 'Merge tags');
    await tester.ensureVisible(confirm);
    await tester.tap(confirm);
    await tester.pump();
    expect(tester.widget<FilledButton>(confirm).onPressed, isNull);
    expect(
      tester
          .widget<TextButton>(find.widgetWithText(TextButton, 'Cancel'))
          .onPressed,
      isNull,
    );
    verify(() => repository.mergeTags('coffee', 'custom')).called(1);
    pending.complete();
    updates.add([custom.copyWith(dayCount: 2)]);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Tags merged'), findsOneWidget);
    expect(find.text('café'), findsNothing);
    expect(find.textContaining('2 days used'), findsOneWidget);
  });

  testWidgets('failed merge stays open and permits a successful retry', (
    tester,
  ) async {
    when(() => repository.previewMerge('coffee', 'custom'))
        .thenAnswer((_) async => preview);
    when(() => repository.mergeTags('coffee', 'custom'))
        .thenThrow(const TagMergeException(TagMergeError.missing));
    await pumpScreen(tester);
    await openMerge(tester);
    await selectTarget(tester);
    await tester.pumpAndSettle();
    final confirm = find.widgetWithText(FilledButton, 'Merge tags');
    await tester.ensureVisible(confirm);
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
      find.textContaining('Check that both tags are still available.'),
      findsOneWidget,
    );
    when(() => repository.mergeTags('coffee', 'custom'))
        .thenAnswer((_) async {});
    await tester.ensureVisible(confirm);
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect(find.text('Tags merged'), findsOneWidget);
  });

  testWidgets('preview failure offers retry before enabling confirmation', (
    tester,
  ) async {
    when(() => repository.previewMerge('coffee', 'custom'))
        .thenThrow(Exception('read'));
    await pumpScreen(tester);
    await openMerge(tester);
    await selectTarget(tester);
    await tester.pumpAndSettle();
    final confirm = find.widgetWithText(FilledButton, 'Merge tags');
    expect(tester.widget<FilledButton>(confirm).onPressed, isNull);
    when(() => repository.previewMerge('coffee', 'custom'))
        .thenAnswer((_) async => preview);
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('Breakfast'), findsOneWidget);
    expect(tester.widget<FilledButton>(confirm).onPressed, isNotNull);
  });

  testWidgets('a removed target clears selection and disables confirmation', (
    tester,
  ) async {
    final updates = StreamController<List<ManagedTag>>();
    addTearDown(updates.close);
    when(repository.watchTags).thenAnswer((_) => updates.stream);
    when(() => repository.previewMerge('coffee', 'custom'))
        .thenAnswer((_) async => preview);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tagManagementRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(home: TagManagementScreen()),
      ),
    );
    updates.add([coffee, custom]);
    await tester.pumpAndSettle();
    await openMerge(tester);
    await selectTarget(tester);
    await tester.pumpAndSettle();
    updates.add([coffee]);
    await tester.pumpAndSettle();
    expect(find.text('Create another tag to merge into.'), findsOneWidget);
    final confirm = find.widgetWithText(FilledButton, 'Merge tags');
    expect(tester.widget<FilledButton>(confirm).onPressed, isNull);
    verifyNever(() => repository.mergeTags(any(), any()));
  });

  testWidgets('lists categories, system origin and usage, then filters tags', (
    tester,
  ) async {
    await pumpScreen(tester);
    expect(find.text('Food · 2 days used · Preinstalled'), findsOneWidget);
    expect(find.text('Uncategorized · 0 days used'), findsOneWidget);
    await tester.enterText(find.byType(TextField), ' CAFÉ ');
    await tester.pump();
    expect(find.text('café'), findsOneWidget);
    expect(find.text('Custom'), findsNothing);
    await tester.enterText(find.byType(TextField), 'absent');
    await tester.pump();
    expect(find.text('No tags match your search.'), findsOneWidget);
  });

  testWidgets('search finds legacy tags with redundant whitespace', (
    tester,
  ) async {
    when(repository.watchTags).thenAnswer(
      (_) => Stream.value([coffee.copyWith(label: 'Petit  déjeuner')]),
    );
    await pumpScreen(tester);
    await tester.enterText(find.byType(TextField), ' PETIT  DÉJEUNER ');
    await tester.pump();
    expect(find.text('Petit  déjeuner'), findsOneWidget);
    expect(find.text('No tags match your search.'), findsNothing);
  });

  testWidgets('rename keeps the dialog open for validation, then saves', (
    tester,
  ) async {
    when(() => repository.renameTag('coffee', '')).thenThrow(
      const TagLabelException(TagLabelError.empty),
    );
    when(() => repository.renameTag('coffee', 'Custom')).thenThrow(
      const TagLabelException(TagLabelError.duplicate),
    );
    when(() => repository.renameTag('coffee', 'Coffee'))
        .thenAnswer((_) async {});
    await pumpScreen(tester);
    await tester.tap(find.text('café'));
    await tester.pumpAndSettle();
    final field = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextField),
    );
    await tester.enterText(field, '');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a label.'), findsOneWidget);
    await tester.enterText(field, 'Custom');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('A tag already has this label.'), findsOneWidget);
    await tester.enterText(field, 'Coffee');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    verify(() => repository.renameTag('coffee', 'Coffee')).called(1);
  });

  testWidgets('deletion shows usage and requires confirmation', (tester) async {
    when(() => repository.deleteTag('coffee')).thenAnswer((_) async {});
    await pumpScreen(tester);
    await openDelete(tester);
    expect(
      find.textContaining('2 day(s), 3 meals and 1 favorite(s)'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Existing meals and favorites keep this tag.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    verifyNever(() => repository.deleteTag(any()));
    await openDelete(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();
    verify(() => repository.deleteTag('coffee')).called(1);
    expect(find.text('Tag deleted'), findsOneWidget);
  });

  testWidgets('live stream refreshes labels and counters', (tester) async {
    final updates = StreamController<List<ManagedTag>>();
    addTearDown(updates.close);
    when(repository.watchTags).thenAnswer((_) => updates.stream);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tagManagementRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(home: TagManagementScreen()),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    updates.add([coffee.copyWith(label: 'Coffee', dayCount: 4)]);
    await tester.pumpAndSettle();
    expect(find.text('Coffee'), findsOneWidget);
    expect(find.textContaining('4 days used'), findsOneWidget);
    updates.add([]);
    await tester.pumpAndSettle();
    expect(find.text('No active tags.'), findsOneWidget);
  });

  testWidgets('read errors offer retry', (tester) async {
    when(repository.watchTags)
        .thenAnswer((_) => Stream.error(Exception('read')));
    await pumpScreen(tester);
    expect(find.text('Something went wrong'), findsOneWidget);
    when(repository.watchTags).thenAnswer((_) => Stream.value([coffee]));
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('café'), findsOneWidget);
  });

  testWidgets('settings opens tag management', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const SettingsScreen()),
        GoRoute(
          path: '/tags',
          name: AppRouter.tagManagement.name,
          builder: (_, _) => const TagManagementScreen(),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tagManagementRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.tap(find.text('Manage tags'));
    await tester.pumpAndSettle();
    expect(find.byType(TagManagementScreen), findsOneWidget);
  });

  test('French usage copy handles singular and plural', () {
    final strings = AppStringsFr();
    expect(strings.tagUsageDays(0), '0 jours d’utilisation');
    expect(strings.tagUsageDays(1), '1 jour d’utilisation');
    expect(strings.tagUsageDays(2), '2 jours d’utilisation');
  });
}
