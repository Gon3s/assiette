import 'dart:async';

import 'package:assiette/features/tag_management/domain/tag_management_repository.dart';
import 'package:assiette/features/tag_management/presentation/tag_management_controller.dart';
import 'package:assiette/utils/tag_labels.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTagManagementRepository extends Mock
    implements TagManagementRepository {}

void main() {
  late MockTagManagementRepository repository;
  late ProviderContainer container;

  setUp(() async {
    repository = MockTagManagementRepository();
    container = ProviderContainer(
      overrides: [
        tagManagementRepositoryProvider.overrideWithValue(repository),
      ],
    )..listen(tagManagementControllerProvider, (_, _) {});
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
}
