@Timeout(Duration(seconds: 30))
library;

import 'dart:async';
import 'dart:io';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/cloud_backup/data/backup_archive_codec.dart';
import 'package:assiette/features/cloud_backup/data/backup_restorer.dart';
import 'package:assiette/features/cloud_backup/data/database_snapshot_codec.dart';
import 'package:assiette/features/tag_management/data/tag_management_repository.dart';
import 'package:assiette/utils/tag_merge_exception.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  late AppDatabase db;
  late DriftTagManagementRepository repository;
  const codec = DatabaseSnapshotCodec();

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftTagManagementRepository(db: db);
    for (final id in ['source', 'target', 'unrelated', 'deleted']) {
      await db.tagsDao.insertTag(TagsCompanion.insert(id: id, label: id));
    }
    await repository.deleteTag('deleted');
  });

  tearDown(() => db.close());

  Future<void> addMeal(String id, List<String> tagIds, int day, int hour) =>
      db.mealsDao.insertMealWithTags(
        MealsCompanion.insert(
          id: id,
          timestamp: DateTime(2026, 10, day, hour, 15).toUtc(),
          mealType: MealType.lunch,
          note: Value(id),
        ),
        tagIds,
      );

  Future<void> addFavorite(String id, List<String> tagIds) =>
      db.templatesDao.insertTemplateWithTags(
        MealTemplatesCompanion.insert(id: id, name: id),
        tagIds,
      );

  Future<void> seedLinks(String sourceId, String targetId) async {
    await addMeal('source-only', [sourceId, 'unrelated'], 25, 0);
    await addMeal('shared', [sourceId, targetId], 25, 23);
    await addMeal('target-only', [targetId], 26, 12);
    await addMeal('deleted-meal', [sourceId], 27, 12);
    await db.mealsDao.softDeleteMeal('deleted-meal');
    await addFavorite('source favorite', [sourceId, 'unrelated']);
    await addFavorite('shared favorite', [sourceId, targetId]);
    await addFavorite('target favorite', [targetId]);
    await addFavorite('deleted favorite', [sourceId]);
    await db.templatesDao.softDeleteTemplate('deleted favorite');
  }

  for (final systemSource in [false, true]) {
    test(
      'merges ${systemSource ? 'system into custom' : 'custom into system'} '
      'without losing links or double-counting local dates',
      () async {
        final system = (await db.tagsDao.watchAll().first).firstWhere(
          (tag) => tag.isSystem,
        );
        final sourceId = systemSource ? system.id : 'source';
        final targetId = systemSource ? 'target' : system.id;
        await seedLinks(sourceId, targetId);
        final beforeMeals = await db.select(db.meals).get();
        final beforeFavorites = await db.select(db.mealTemplates).get();
        final preview = await repository.previewMerge(sourceId, targetId);
        expect(preview.source.dayCount, 1);
        expect(preview.source.mealCount, 2);
        expect(preview.target.dayCount, 2);
        expect(preview.favoriteNames, ['shared favorite', 'source favorite']);

        final changes = StreamIterator(repository.watchTags());
        addTearDown(changes.cancel);
        await changes.moveNext();
        await repository.mergeTags(sourceId, targetId);
        await changes.moveNext();
        expect(changes.current.any((tag) => tag.id == sourceId), isFalse);
        final target = changes.current.singleWhere((tag) => tag.id == targetId);
        expect(target.dayCount, 2);
        expect(target.mealCount, 3);
        expect(target.favoriteCount, 3);
        expect(target.isSystem, !systemSource);
        final storedSource = await (db.select(
          db.tags,
        )..where((tag) => tag.id.equals(sourceId))).getSingle();
        expect(storedSource.deletedAt, isNotNull);
        expect(storedSource.isSystem, systemSource);
        final mealLinks = await db.select(db.mealTags).get();
        final favoriteLinks = await db.select(db.templateTags).get();
        expect(mealLinks.any((link) => link.tagId == sourceId), isFalse);
        expect(favoriteLinks.any((link) => link.tagId == sourceId), isFalse);
        expect(
          mealLinks.where((link) => link.mealId == 'shared'),
          hasLength(1),
        );
        expect(
          favoriteLinks.where((link) => link.templateId == 'shared favorite'),
          hasLength(1),
        );
        expect(
          mealLinks.where((link) => link.tagId == 'unrelated'),
          hasLength(1),
        );
        expect(
          favoriteLinks.where((link) => link.tagId == 'unrelated'),
          hasLength(1),
        );
        final afterMeals = await db.select(db.meals).get();
        for (final before in beforeMeals) {
          final after = afterMeals.singleWhere((meal) => meal.id == before.id);
          expect(after.copyWith(updatedAt: before.updatedAt), before);
        }
        final afterFavorites = await db.select(db.mealTemplates).get();
        for (final before in beforeFavorites) {
          final after = afterFavorites.singleWhere(
            (favorite) => favorite.id == before.id,
          );
          expect(after.copyWith(updatedAt: before.updatedAt), before);
        }
        await db.mealsDao.restoreMeal('deleted-meal');
        final restoredUsage = (await repository.watchTags().first).singleWhere(
          (tag) => tag.id == targetId,
        );
        expect(restoredUsage.dayCount, 3);
        expect(
          mealLinks.singleWhere((link) => link.mealId == 'deleted-meal').tagId,
          targetId,
        );
        expect(
          favoriteLinks
              .singleWhere((link) => link.templateId == 'deleted favorite')
              .tagId,
          targetId,
        );
      },
    );
  }

  test(
    'rejects identical, missing or deleted tags before changing rows',
    () async {
      await seedLinks('source', 'target');
      final before = await codec.export(db);
      for (final pair in [
        ('source', 'source', TagMergeError.sameTag),
        ('missing', 'target', TagMergeError.missing),
        ('source', 'missing', TagMergeError.missing),
        ('deleted', 'target', TagMergeError.missing),
        ('source', 'deleted', TagMergeError.missing),
      ]) {
        final error = throwsA(
          isA<TagMergeException>().having(
            (error) => error.reason,
            'reason',
            pair.$3,
          ),
        );
        await expectLater(repository.previewMerge(pair.$1, pair.$2), error);
        await expectLater(repository.mergeTags(pair.$1, pair.$2), error);
        expect(await codec.export(db), before);
      }
    },
  );

  test(
    'rolls back link rewrites and timestamps when the last step fails',
    () async {
      await seedLinks('source', 'target');
      final before = await codec.export(db);
      await db.customStatement(
        'CREATE TRIGGER reject_merge BEFORE UPDATE OF deleted_at ON tags '
        "WHEN OLD.id = 'source' "
        "BEGIN SELECT RAISE(ABORT, 'simulated merge failure'); END",
      );
      await expectLater(
        repository.mergeTags('source', 'target'),
        throwsException,
      );
      expect(await codec.export(db), before);
    },
  );

  test('preserves a merge through ZIP backup and restoration', () async {
    await seedLinks('source', 'target');
    await repository.mergeTags('source', 'target');
    final snapshot = await codec.export(db);
    final bytes = await const BackupArchiveCodec().encode(snapshot);
    await db.close();
    db = AppDatabase(NativeDatabase.memory());
    final restored = db;
    final directory = await Directory.systemTemp.createTemp(
      'assiette-tag-merge-',
    );
    addTearDown(() async {
      await directory.delete(recursive: true);
    });
    await const BackupRestorer().restore(
      restored,
      bytes,
      Directory(p.join(directory.path, 'photos')),
    );
    expect(await codec.export(restored), snapshot);
    final active = await restored.tagsDao.watchAll().first;
    expect(active.any((tag) => tag.id == 'source'), isFalse);
    final usage = (await restored.tagsDao.watchWithUsage().first).singleWhere(
      (row) => row.tag.id == 'target',
    );
    expect(usage.dayCount, 2);
    expect(usage.favoriteCount, 3);
  });
}
