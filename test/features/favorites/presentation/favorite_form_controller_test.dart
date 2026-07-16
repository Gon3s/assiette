@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:assiette/features/favorites/presentation/favorite_form_controller.dart';
import 'package:assiette/features/favorites/presentation/favorites_providers.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_photo_service.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class MockMealEntryRepository extends Mock implements MealEntryRepository {}

class MockMealPhotoService extends Mock implements MealPhotoService {}

void main() {
  late MockFavoritesRepository favoritesRepository;
  late MockMealEntryRepository mealEntryRepository;
  late MockMealPhotoService photoService;

  const tag = TagOption(id: 'tag-1', label: 'café', isSystem: true);
  const existing = MealTemplateOption(
    id: 'template-1',
    name: 'Salade César',
    defaultMealType: MealType.lunch,
    defaultPhotoPath: '/photos/salad.jpg',
    tags: [tag],
  );

  setUp(() {
    favoritesRepository = MockFavoritesRepository();
    mealEntryRepository = MockMealEntryRepository();
    photoService = MockMealPhotoService();
  });

  ProviderContainer makeContainer({
    List<MealTemplateOption> favorites = const [],
  }) {
    final container = ProviderContainer(
      overrides: [
        favoritesRepositoryProvider.overrideWithValue(favoritesRepository),
        mealEntryRepositoryProvider.overrideWithValue(mealEntryRepository),
        mealPhotoServiceProvider.overrideWithValue(photoService),
        favoriteTemplatesProvider.overrideWith(
          (ref) => Stream.value(favorites),
        ),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('build', () {
    test('starts blank when creating a new favorite', () {
      final container = makeContainer();
      final state = container.read(favoriteFormControllerProvider(null));

      expect(state.id, isNull);
      expect(state.name, isEmpty);
      expect(state.mealType, isNull);
      expect(state.selectedTags, isEmpty);
      expect(state.photoPath, isNull);
    });

    test('seeds from the matching favorite when editing', () async {
      final container = makeContainer(favorites: [existing]);
      // Keep favoriteTemplatesProvider alive (as the list screen would) and
      // let its stream resolve before reading the form controller.
      // Can't cascade: the second call's Future must be awaited, which a
      // void-cascade would discard.
      // ignore: cascade_invocations
      container.listen(favoriteTemplatesProvider, (_, _) {});
      await container.read(favoriteTemplatesProvider.future);

      final state = container.read(
        favoriteFormControllerProvider('template-1'),
      );

      expect(state.id, 'template-1');
      expect(state.name, 'Salade César');
      expect(state.mealType, MealType.lunch);
      expect(state.photoPath, '/photos/salad.jpg');
      expect(state.selectedTags, [tag]);
    });
  });

  group('FavoriteFormController', () {
    test('setName, addTag (no dup) and removeTag mutate the form', () {
      final container = makeContainer();
      final controller =
          container.read(
              favoriteFormControllerProvider(null).notifier,
            )
            ..setName('Pizza')
            ..addTag(tag)
            ..addTag(tag);

      var state = container.read(favoriteFormControllerProvider(null));
      expect(state.name, 'Pizza');
      expect(state.selectedTags, [tag]);

      controller.removeTag(tag);
      state = container.read(favoriteFormControllerProvider(null));
      expect(state.selectedTags, isEmpty);
    });

    test('createAndAddTag creates and selects the tag', () async {
      when(() => mealEntryRepository.createTag('pizza')).thenAnswer(
        (_) async =>
            const TagOption(id: 'tag-2', label: 'pizza', isSystem: false),
      );

      final container = makeContainer();
      await container
          .read(favoriteFormControllerProvider(null).notifier)
          .createAndAddTag('  pizza  ');

      verify(() => mealEntryRepository.createTag('pizza')).called(1);
      expect(
        container
            .read(favoriteFormControllerProvider(null))
            .selectedTags
            .single
            .label,
        'pizza',
      );
    });

    test('takePhoto stores the returned path, removePhoto clears it', () async {
      when(
        photoService.captureFromCamera,
      ).thenAnswer((_) async => '/photos/a.jpg');

      final container = makeContainer();
      final controller = container.read(
        favoriteFormControllerProvider(null).notifier,
      );
      await controller.takePhoto();
      expect(
        container.read(favoriteFormControllerProvider(null)).photoPath,
        '/photos/a.jpg',
      );

      controller.removePhoto();
      expect(
        container.read(favoriteFormControllerProvider(null)).photoPath,
        isNull,
      );
    });

    test('save ignores a blank name', () async {
      final container = makeContainer();
      final saved = await container
          .read(favoriteFormControllerProvider(null).notifier)
          .save();

      expect(saved, isFalse);
      verifyNever(
        () => favoritesRepository.createFavorite(
          name: any(named: 'name'),
          tagIds: any(named: 'tagIds'),
        ),
      );
    });

    test('save creates a new favorite when id is null', () async {
      when(
        () => favoritesRepository.createFavorite(
          name: any(named: 'name'),
          tagIds: any(named: 'tagIds'),
          defaultMealType: any(named: 'defaultMealType'),
          defaultPhotoPath: any(named: 'defaultPhotoPath'),
        ),
      ).thenAnswer((_) async {});

      final container = makeContainer();
      final controller =
          container.read(
              favoriteFormControllerProvider(null).notifier,
            )
            ..setName('  Pizza  ')
            ..addTag(tag)
            ..setMealType(MealType.dinner);

      final saved = await controller.save();

      expect(saved, isTrue);
      verify(
        () => favoritesRepository.createFavorite(
          name: 'Pizza',
          tagIds: ['tag-1'],
          defaultMealType: MealType.dinner,
        ),
      ).called(1);
    });

    test('save updates the favorite when id is set', () async {
      when(
        () => favoritesRepository.updateFavorite(
          id: any(named: 'id'),
          name: any(named: 'name'),
          tagIds: any(named: 'tagIds'),
          defaultMealType: any(named: 'defaultMealType'),
          defaultPhotoPath: any(named: 'defaultPhotoPath'),
        ),
      ).thenAnswer((_) async {});

      final container = makeContainer(favorites: [existing]);
      // Can't cascade: the second call's Future must be awaited, which a
      // void-cascade would discard.
      // ignore: cascade_invocations
      container.listen(favoriteTemplatesProvider, (_, _) {});
      await container.read(favoriteTemplatesProvider.future);
      final controller = container.read(
        favoriteFormControllerProvider('template-1').notifier,
      )..setName('Salade César v2');

      final saved = await controller.save();

      expect(saved, isTrue);
      verify(
        () => favoritesRepository.updateFavorite(
          id: 'template-1',
          name: 'Salade César v2',
          tagIds: ['tag-1'],
          defaultMealType: MealType.lunch,
          defaultPhotoPath: '/photos/salad.jpg',
        ),
      ).called(1);
    });
  });
}
