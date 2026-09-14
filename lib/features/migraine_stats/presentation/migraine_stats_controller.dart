import 'package:assiette/features/migraine_stats/domain/migraine_stats.dart';
import 'package:assiette/features/migraine_stats/domain/migraine_stats_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'migraine_stats_controller.g.dart';

/// Period currently selected on the migraine statistics screen.
@riverpod
class SelectedMigraineStatsPeriod extends _$SelectedMigraineStatsPeriod {
  @override
  MigraineStatsPeriod build() => MigraineStatsPeriod.thirtyDays;

  /// Selects a new statistics period.
  // This action reads more clearly at the call site than a write-only setter.
  // ignore: use_setters_to_change_properties
  void select(MigraineStatsPeriod period) => state = period;
}

/// Loads migraine statistics for [period].
@riverpod
Future<MigraineStats> migraineStats(Ref ref, MigraineStatsPeriod period) =>
    ref.watch(migraineStatsRepositoryProvider).load(period, DateTime.now());
