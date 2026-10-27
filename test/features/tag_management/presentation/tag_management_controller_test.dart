import 'dart:async';

import 'package:assiette/features/tag_management/domain/tag_management_repository.dart';
import 'package:assiette/features/tag_management/presentation/tag_management_controller.dart';
import 'package:assiette/utils/tag_labels.dart';
import 'package:assiette/utils/tag_merge_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTagManagementRepository extends Mock
    implements TagManagementRepository {}

void main() {
  late MockTagManagementRepository repository;
  late ProviderContainer container;
  late ProviderSubscription<AsyncValue<void>> subscription;

  setUp(() async {
    repository = MockTagManagementRepository();
    container = ProviderContainer(
      overrides: [
        tagManagementRepositoryProvider.overrideWithValue(repository),
      ],
    );
    subscription = container.listen(tagManagementControllerProvider, (_, _) {});
    await container.read(tagManagementControllerProvider.future);
  });

  tearDown(() => container.dispose());

  test(
    'rename exposes loading then success and rejects concurrent mutations',
    () async {
      final pending = Completer<void>();
      when(() => repository.renameTag('tag', 'New'))
          .thenAnswer((_) => pending.future);
      final controller = container.read(
        tagManagementControllerProvider.notifier,
      );
      final operation = controller.renameTag('tag', 'New');
      expect(container.read(tagManagementControllerProvider).isLoading, isTrue);
      expect(await controller.deleteTag('tag'), isFalse);
      verifyNever(() => repository.deleteTag(any()));
      pending.complete();
      expect(await operation, isTrue);
      expect(container.read(tagManagementControllerProvider).hasError, isFalse);
    },
  );

  test('rename exposes validation error and can recover on retry', () async {
    when(() => repository.renameTag('tag', '')).thenThrow(
      const TagLabelException(TagLabelError.empty),
    );
    when(() => repository.renameTag('tag', 'Valid')).thenAnswer((_) async {});
    final controller = container.read(tagManagementControllerProvider.notifier);
    expect(await controller.renameTag('tag', ''), isFalse);
    expect(
      container.read(tagManagementControllerProvider).error,
      isA<TagLabelException>(),
    );
    expect(await controller.renameTag('tag', 'Valid'), isTrue);
    expect(container.read(tagManagementControllerProvider).hasError, isFalse);
  });

  test('delete exposes failure without claiming success', () async {
    when(() => repository.deleteTag('tag')).thenThrow(Exception('storage'));
    final controller = container.read(tagManagementControllerProvider.notifier);
    expect(await controller.deleteTag('tag'), isFalse);
    expect(container.read(tagManagementControllerProvider).hasError, isTrue);
  });

  test('merge prevents concurrent edits and reports completion', () async {
    final pending = Completer<void>();
    when(() => repository.mergeTags('source', 'target'))
        .thenAnswer((_) => pending.future);
    final controller = container.read(tagManagementControllerProvider.notifier);
    final operation = controller.mergeTags('source', 'target');
    expect(container.read(tagManagementControllerProvider).isLoading, isTrue);
    expect(await controller.mergeTags('source', 'target'), isFalse);
    expect(await controller.renameTag('source', 'Renamed'), isFalse);
    expect(await controller.deleteTag('target'), isFalse);
    verifyNever(() => repository.renameTag(any(), any()));
    verifyNever(() => repository.deleteTag(any()));
    pending.complete();
    expect(await operation, isTrue);
    verify(() => repository.mergeTags('source', 'target')).called(1);
  });

  test('merge exposes invalid pairs and can recover on retry', () async {
    when(() => repository.mergeTags('source', 'missing')).thenThrow(
      const TagMergeException(TagMergeError.missing),
    );
    when(() => repository.mergeTags('source', 'target'))
        .thenAnswer((_) async {});
    final controller = container.read(tagManagementControllerProvider.notifier);
    expect(await controller.mergeTags('source', 'missing'), isFalse);
    expect(
      container.read(tagManagementControllerProvider).error,
      isA<TagMergeException>(),
    );
    expect(await controller.mergeTags('source', 'target'), isTrue);
    expect(container.read(tagManagementControllerProvider).hasError, isFalse);
  });

  for (final rename in [false, true]) {
    test('completes pending ${rename ? "rename" : "deletion"} after leaving '
        'the screen', () async {
      final pending = Completer<void>();
      if (rename) {
        when(() => repository.renameTag('tag', 'New'))
            .thenAnswer((_) => pending.future);
      } else {
        when(() => repository.deleteTag('tag'))
            .thenAnswer((_) => pending.future);
      }
      final controller = container.read(
        tagManagementControllerProvider.notifier,
      );
      final operation = rename
          ? controller.renameTag('tag', 'New')
          : controller.deleteTag('tag');
      subscription.close();
      await container.pump();
      pending.complete();
      expect(await operation, isTrue);
    });
  }
}
