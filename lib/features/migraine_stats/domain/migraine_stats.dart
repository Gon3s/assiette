import 'package:freezed_annotation/freezed_annotation.dart';

part 'migraine_stats.freezed.dart';

/// Time ranges offered by the migraine statistics screen.
enum MigraineStatsPeriod {
  /// The last 30 complete or current calendar days.
  thirtyDays(30),

  /// The last 90 complete or current calendar days.
  ninetyDays(90),

  /// The last 365 complete or current calendar days.
  oneYear(365);

  const MigraineStatsPeriod(this.days);

  /// Number of calendar days included in the period.
  final int days;
}

/// Aggregated migraine and medication data for one selected period.
@freezed
abstract class MigraineStats with _$MigraineStats {
  /// Creates an immutable statistics snapshot.
  const factory MigraineStats({
    required DateTime start,
    required DateTime end,
    required int migraineCount,
    required int migraineDays,
    required Duration? averageDuration,
    required double? averageMaximumIntensity,
    required int medicationIntakeCount,
    required int medicationDays,
    required List<MigraineFrequencyBucket> frequency,
    required List<MedicationStats> medications,
  }) = _MigraineStats;
}

/// Number of migraine episodes starting in a slice of the selected period.
@freezed
abstract class MigraineFrequencyBucket with _$MigraineFrequencyBucket {
  /// Creates a frequency bucket.
  const factory MigraineFrequencyBucket({
    required DateTime start,
    required DateTime end,
    required int count,
  }) = _MigraineFrequencyBucket;
}

/// Usage summary for a medication name entered by the user.
@freezed
abstract class MedicationStats with _$MedicationStats {
  /// Creates an immutable medication summary.
  const factory MedicationStats({
    required String name,
    required int intakeCount,
    required int linkedMigraineCount,
    required Duration? averageDelayAfterMigraineStart,
  }) = _MedicationStats;
}
