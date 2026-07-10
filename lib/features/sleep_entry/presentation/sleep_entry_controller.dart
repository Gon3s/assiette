import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_entry_repository.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sleep_entry_controller.g.dart';

/// Holds and mutates the sleep entry detail form (quality, bed/wake time),
/// seeded from the sleep already logged for the selected day, and performs
/// the final save.
@riverpod
class SleepEntryController extends _$SleepEntryController {
  @override
  SleepEntryState build() {
    final sleep = ref.read(daySleepProvider).value;
    return SleepEntryState(
      quality: sleep?.quality ?? 2,
      bedTime: sleep?.bedTime,
      wakeTime: sleep?.wakeTime,
    );
  }

  /// Changes the sleep quality (1-3).
  void setQuality(int quality) => state = state.copyWith(quality: quality);

  /// Changes the bed time (kept local; converted to UTC on save).
  void setBedTime(DateTime bedTime) =>
      state = state.copyWith(bedTime: bedTime);

  /// Clears the optional bed time.
  void clearBedTime() => state = state.copyWith(bedTime: null);

  /// Changes the wake time (kept local; converted to UTC on save).
  void setWakeTime(DateTime wakeTime) =>
      state = state.copyWith(wakeTime: wakeTime);

  /// Clears the optional wake time.
  void clearWakeTime() => state = state.copyWith(wakeTime: null);

  /// Persists the sleep entry for the selected day. Returns true on success.
  Future<bool> save() async {
    if (state.isSaving) return false;
    state = state.copyWith(isSaving: true);
    try {
      final day = ref.read(selectedDateProvider);
      await ref
          .read(sleepEntryRepositoryProvider)
          .saveSleepEntry(
            day: day,
            quality: state.quality,
            bedTime: state.bedTime,
            wakeTime: state.wakeTime,
          );
      return true;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
