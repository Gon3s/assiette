import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_entry_state.freezed.dart';

/// Form state of the sleep entry detail screen.
@freezed
abstract class SleepEntryState with _$SleepEntryState {
  /// Creates a [SleepEntryState].
  const factory SleepEntryState({
    required int quality,
    DateTime? bedTime,
    DateTime? wakeTime,
    @Default(false) bool isSaving,
  }) = _SleepEntryState;
}
