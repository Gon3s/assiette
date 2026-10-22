import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_summary.freezed.dart';

/// The sleep entry logged for a given night.
@freezed
abstract class SleepSummary with _$SleepSummary {
  /// Creates a [SleepSummary].
  const factory SleepSummary({
    int? quality,
    DateTime? bedTime,
    DateTime? wakeTime,
    String? note,
    String? id,
  }) = _SleepSummary;
}
