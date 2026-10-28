import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_entry_repository.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sleep_entry_controller.g.dart';

enum _SleepField { quality, note, bedTime, wakeTime }

/// Holds and mutates the sleep entry detail form (quality, bed/wake time),
/// seeded from the sleep already logged for the selected day, and performs
/// the final save.
@riverpod
class SleepEntryController extends _$SleepEntryController {
  final _edited = <_SleepField>{};

  @override
  SleepEntryState build() {
    final day = ref.watch(selectedDateProvider);
    _edited.clear();
    ref.listen(daySleepProvider(day), (_, next) {
      if (!next.hasValue) return;
      final sleep = next.value;
      state = state.copyWith(
        id: sleep?.id,
        quality: _edited.contains(_SleepField.quality)
            ? state.quality
            : sleep?.quality,
        note: _edited.contains(_SleepField.note) ? state.note : sleep?.note,
        bedTime: _edited.contains(_SleepField.bedTime)
            ? state.bedTime
            : sleep?.bedTime,
        wakeTime: _edited.contains(_SleepField.wakeTime)
            ? state.wakeTime
            : sleep?.wakeTime,
      );
    });
    final sleep = ref.read(daySleepProvider(day)).value;
    return SleepEntryState(
      id: sleep?.id,
      quality: sleep?.quality,
      bedTime: sleep?.bedTime,
      wakeTime: sleep?.wakeTime,
      note: sleep?.note,
    );
  }

  /// Changes the sleep quality (1-3).
  void setQuality(int? quality) {
    _edited.add(_SleepField.quality);
    state = state.copyWith(quality: quality);
  }

  void setNote(String note) {
    _edited.add(_SleepField.note);
    state = state.copyWith(note: note);
  }

  /// Changes the bed time (kept local; converted to UTC on save).
  void setBedTime(DateTime bedTime) {
    _edited.add(_SleepField.bedTime);
    state = state.copyWith(bedTime: bedTime);
  }

  /// Clears the optional bed time.
  void clearBedTime() {
    _edited.add(_SleepField.bedTime);
    state = state.copyWith(bedTime: null);
  }

  /// Changes the wake time (kept local; converted to UTC on save).
  void setWakeTime(DateTime wakeTime) {
    _edited.add(_SleepField.wakeTime);
    state = state.copyWith(wakeTime: wakeTime);
  }

  /// Clears the optional wake time.
  void clearWakeTime() {
    _edited.add(_SleepField.wakeTime);
    state = state.copyWith(wakeTime: null);
  }

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
            note: state.note,
          );
      return true;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  /// Soft-deletes the sleep entry. Returns false when nothing is logged
  /// yet (no id) or while another save/delete is in flight.
  Future<bool> delete() async {
    final id = state.id;
    if (id == null || state.isSaving) return false;
    state = state.copyWith(isSaving: true);
    try {
      await ref.read(dayViewRepositoryProvider).deleteSleepEntry(id);
      return true;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
