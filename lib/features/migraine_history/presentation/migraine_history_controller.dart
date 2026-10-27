import 'package:assiette/features/migraine_history/domain/migraine_history_entry.dart';
import 'package:assiette/features/migraine_history/domain/migraine_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'migraine_history_controller.g.dart';

@riverpod
Stream<List<MigraineHistoryEntry>> migraineHistory(Ref ref) =>
    ref.watch(migraineHistoryRepositoryProvider).watchHistory();
