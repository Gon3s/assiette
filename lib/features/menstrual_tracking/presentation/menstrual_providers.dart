import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_tracking_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menstrual_providers.g.dart';

@riverpod
Stream<MenstrualPreferences> menstrualPreferences(Ref ref) =>
    ref.watch(menstrualTrackingRepositoryProvider).watchPreferences();

@riverpod
Stream<MenstrualObservation?> menstrualDay(Ref ref, String date) =>
    ref.watch(menstrualTrackingRepositoryProvider).watchDay(date);

@riverpod
class MenstrualActions extends _$MenstrualActions {
  @override
  Future<void> build() async {}

  Future<bool> _run(Future<void> Function() action) async {
    if (state.isLoading) return false;
    state = const AsyncLoading();
    final result = await AsyncValue.guard(action);
    if (!ref.mounted) return false;
    state = result;
    return !result.hasError;
  }

  Future<bool> save(MenstrualObservation observation) => _run(
    () => ref.read(menstrualTrackingRepositoryProvider).save(observation),
  );

  Future<bool> delete(String date) => _run(
    () => ref.read(menstrualTrackingRepositoryProvider).delete(date),
  );

  Future<bool> setPreferences(MenstrualPreferences preferences) => _run(
    () => ref
        .read(menstrualTrackingRepositoryProvider)
        .setPreferences(preferences),
  );

  Future<bool> purge() => _run(
    () => ref.read(menstrualTrackingRepositoryProvider).purge(),
  );
}
