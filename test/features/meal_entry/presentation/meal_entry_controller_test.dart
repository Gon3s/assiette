@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_photo_service.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMealEntryRepository extends Mock implements MealEntryRepository {}

class MockMealPhotoService extends Mock implements MealPhotoService {}

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late MockMealEntryRepository repository;
  late MockMealPhotoService photoService;
  late MockFavoritesRepository favoritesRepository;

  const tag = TagOption(id: 'tag-1', label: 'café', isSystem: true);

  setUpAll(() {
    registerFallbackValue(MealType.lunch);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    repository = MockMealEntryRepository();
    photoService = MockMealPhotoService();
    favoritesRepository = MockFavoritesRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        mealEntryRepositoryProvider.overrideWithValue(repository),
        mealPhotoServiceProvider.overrideWithValue(photoService),
        favoritesRepositoryProvider.overrideWithValue(favoritesRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('defaultMealTypeFor', () {
    test('maps hours to meal types', () {
      expect(defaultMealTypeFor(DateTime(2026, 1, 1, 8)), MealType.breakfast);
      expect(defaultMealTypeFor(DateTime(2026, 1, 1, 12)), MealType.lunch);
      expect(defaultMealTypeFor(DateTime(2026, 1, 1, 16)), MealType.snack);
      expect(defaultMealTypeFor(DateTime(2026, 1, 1, 20)), MealType.dinner);
    });
  });

  group('MealEntryController', () {
    test('initial state defaults to now and no tags', () {
      final container = makeContainer();
      final state = container.read(mealEntryControllerProvider);

      expect(state.selectedTags, isEmpty);
      expect(state.photoPath, isNull);
      expect(state.note, isEmpty);
      expect(state.isSaving, isFalse);
      expect(state.mealType, defaultMealTypeFor(DateTime.now()));
    });

    test('addTag ignores duplicates and removeTag removes', () {
      final container = makeContainer();
      final controller = container.read(mealEntryControllerProvider.notifier)
        ..addTag(tag)
        ..addTag(tag);

      expect(
        container.read(mealEntryControllerProvider).selectedTags,
        hasLength(1),
      );

      controller.removeTag(tag);
      expect(
        container.read(mealEntryControllerProvider).selectedTags,
        isEmpty,
      );
    });

    test('createAndAddTag trims, creates and selects the tag', () async {
      when(() => repository.createTag('pizza')).thenAnswer(
        (_) async =>
            const TagOption(id: 'tag-2', label: 'pizza', isSystem: false),
      );

      final container = makeContainer();
      await container
          .read(mealEntryControllerProvider.notifier)
          .createAndAddTag('  pizza  ');

      verify(() => repository.createTag('pizza')).called(1);
      expect(
        container.read(mealEntryControllerProvider).selectedTags.single.label,
        'pizza',
      );
    });

    test('createAndAddTag ignores blank labels', () async {
      final container = makeContainer();
      await container
          .read(mealEntryControllerProvider.notifier)
          .createAndAddTag('   ');

      verifyNever(() => repository.createTag(any()));
    });

    test('takePhoto stores the returned path, keeps it on cancel', () async {
      when(
        photoService.captureFromCamera,
      ).thenAnswer((_) async => '/photos/a.jpg');

      final container = makeContainer();
      final controller = container.read(mealEntryControllerProvider.notifier);
      await controller.takePhoto();
      expect(
        container.read(mealEntryControllerProvider).photoPath,
        '/photos/a.jpg',
      );

      when(photoService.captureFromCamera).thenAnswer((_) async => null);
      await controller.takePhoto();
      expect(
        container.read(mealEntryControllerProvider).photoPath,
        '/photos/a.jpg',
      );

      controller.removePhoto();
      expect(container.read(mealEntryControllerProvider).photoPath, isNull);
    });

    test(
      'save passes the form to the repository and reports success',
      () async {
        when(
          () => repository.saveMeal(
            timestamp: any(named: 'timestamp'),
            mealType: any(named: 'mealType'),
            tagIds: any(named: 'tagIds'),
            photoPath: any(named: 'photoPath'),
            note: any(named: 'note'),
          ),
        ).thenAnswer((_) async {});

        final container = makeContainer();
        final controller = container.read(mealEntryControllerProvider.notifier)
          ..addTag(tag)
          ..setNote('miam')
          ..setMealType(MealType.dinner);

        final saved = await controller.save();

        expect(saved, isTrue);
        expect(container.read(mealEntryControllerProvider).isSaving, isFalse);
        verify(
          () => repository.saveMeal(
            timestamp: any(named: 'timestamp'),
            mealType: MealType.dinner,
            tagIds: ['tag-1'],
            note: 'miam',
          ),
        ).called(1);
      },
    );

    test('save resets isSaving and rethrows on failure', () async {
      when(
        () => repository.saveMeal(
          timestamp: any(named: 'timestamp'),
          mealType: any(named: 'mealType'),
          tagIds: any(named: 'tagIds'),
          photoPath: any(named: 'photoPath'),
          note: any(named: 'note'),
        ),
      ).thenThrow(StateError('db unavailable'));

      final container = makeContainer();
      final controller = container.read(mealEntryControllerProvider.notifier);

      await expectLater(controller.save(), throwsStateError);
      expect(container.read(mealEntryControllerProvider).isSaving, isFalse);
    });

    test(
      'saveAsFavorite passes the form to the favorites repository',
      () async {
        when(
          () => favoritesRepository.createFavorite(
            name: any(named: 'name'),
            tagIds: any(named: 'tagIds'),
            defaultMealType: any(named: 'defaultMealType'),
            defaultPhotoPath: any(named: 'defaultPhotoPath'),
          ),
        ).thenAnswer((_) async {});

        final container = makeContainer();
        final controller = container.read(mealEntryControllerProvider.notifier)
          ..addTag(tag)
          ..setMealType(MealType.dinner);

        final saved = await controller.saveAsFavorite('  Pizza du vendredi  ');

        expect(saved, isTrue);
        expect(container.read(mealEntryControllerProvider).isSaving, isFalse);
        verify(
          () => favoritesRepository.createFavorite(
            name: 'Pizza du vendredi',
            tagIds: ['tag-1'],
            defaultMealType: MealType.dinner,
          ),
        ).called(1);
      },
    );

    test('saveAsFavorite ignores a blank name', () async {
      final container = makeContainer();
      final saved = await container
          .read(mealEntryControllerProvider.notifier)
          .saveAsFavorite('   ');

      expect(saved, isFalse);
      verifyNever(
        () => favoritesRepository.createFavorite(
          name: any(named: 'name'),
          tagIds: any(named: 'tagIds'),
        ),
      );
    });
  });
}
