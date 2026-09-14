import 'dart:math' as math;

import 'package:assiette/data/daos/medication_intakes_dao.dart';
import 'package:assiette/data/daos/symptoms_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/migraine_stats/domain/migraine_stats.dart';
import 'package:assiette/features/migraine_stats/domain/migraine_stats_repository.dart';

/// Drift-backed implementation of [MigraineStatsRepository].
class DriftMigraineStatsRepository implements MigraineStatsRepository {
  /// Creates a repository backed by the supplied DAOs.
  DriftMigraineStatsRepository({
    required SymptomsDao symptomsDao,
    required MedicationIntakesDao medicationIntakesDao,
  }) : _symptomsDao = symptomsDao,
       _medicationIntakesDao = medicationIntakesDao;

  final SymptomsDao _symptomsDao;
  final MedicationIntakesDao _medicationIntakesDao;

  @override
  Future<MigraineStats> load(
    MigraineStatsPeriod period,
    DateTime now,
  ) async {
    final localEnd = DateTime(now.year, now.month, now.day).add(
      const Duration(days: 1),
    );
    final rangeStart = localEnd.subtract(Duration(days: period.days)).toUtc();
    final rangeEnd = localEnd.toUtc();

    final results = await Future.wait([
      _symptomsDao.getRange(rangeStart, rangeEnd),
      _medicationIntakesDao.getRange(rangeStart, rangeEnd),
    ]);
    final migraines = (results[0] as List<Symptom>)
        .where((symptom) => symptom.type == SymptomType.migraine)
        .toList();
    final intakes = results[1] as List<MedicationIntake>;

    return MigraineStats(
      start: rangeStart,
      end: rangeEnd,
      migraineCount: migraines.length,
      migraineDays: _calendarDayCount(
        migraines.map((migraine) => migraine.timestamp),
      ),
      averageDuration: _averageDuration(migraines),
      averageMaximumIntensity: _averageMaximumIntensity(migraines),
      medicationIntakeCount: intakes.length,
      medicationDays: _calendarDayCount(
        intakes.map((intake) => intake.timestamp),
      ),
      frequency: _frequencyBuckets(
        migraines: migraines,
        start: rangeStart,
        end: rangeEnd,
        period: period,
      ),
      medications: _medicationStats(intakes, migraines),
    );
  }

  static int _calendarDayCount(Iterable<DateTime> timestamps) => timestamps
      .map((value) {
        final local = value.toLocal();
        return '${local.year}-${local.month}-${local.day}';
      })
      .toSet()
      .length;

  static Duration? _averageDuration(List<Symptom> migraines) {
    final durations = <Duration>[
      for (final migraine in migraines)
        if (migraine.startedAt case final start?)
          if (migraine.endedAt case final end?)
            if (!end.isBefore(start)) end.difference(start),
    ];
    if (durations.isEmpty) return null;
    final totalMicroseconds = durations.fold<int>(
      0,
      (sum, duration) => sum + duration.inMicroseconds,
    );
    return Duration(microseconds: totalMicroseconds ~/ durations.length);
  }

  static double? _averageMaximumIntensity(List<Symptom> migraines) {
    final values = migraines
        .map(
          (migraine) =>
              migraine.maximumIntensity ??
              migraine.initialIntensity ??
              migraine.intensity,
        )
        .nonNulls
        .toList();
    if (values.isEmpty) return null;
    return values.reduce((first, second) => first + second) / values.length;
  }

  static List<MigraineFrequencyBucket> _frequencyBuckets({
    required List<Symptom> migraines,
    required DateTime start,
    required DateTime end,
    required MigraineStatsPeriod period,
  }) {
    final bucketDays = switch (period) {
      MigraineStatsPeriod.thirtyDays => 7,
      MigraineStatsPeriod.ninetyDays => 14,
      MigraineStatsPeriod.oneYear => 30,
    };
    final bucketCount = (period.days / bucketDays).ceil();
    return [
      for (var index = 0; index < bucketCount; index++)
        () {
          final bucketStart = start.add(Duration(days: index * bucketDays));
          final bucketEnd = DateTime.fromMillisecondsSinceEpoch(
            math.min(
              bucketStart
                  .add(Duration(days: bucketDays))
                  .millisecondsSinceEpoch,
              end.millisecondsSinceEpoch,
            ),
            isUtc: true,
          );
          return MigraineFrequencyBucket(
            start: bucketStart,
            end: bucketEnd,
            count: migraines
                .where(
                  (migraine) =>
                      !migraine.timestamp.isBefore(bucketStart) &&
                      migraine.timestamp.isBefore(bucketEnd),
                )
                .length,
          );
        }(),
    ];
  }

  static List<MedicationStats> _medicationStats(
    List<MedicationIntake> intakes,
    List<Symptom> migraines,
  ) {
    final migrainesById = {
      for (final migraine in migraines) migraine.id: migraine,
    };
    final grouped = <String, _MedicationAccumulator>{};
    for (final intake in intakes) {
      final displayName = intake.name.trim();
      if (displayName.isEmpty) continue;
      final accumulator = grouped.putIfAbsent(
        displayName.toLowerCase(),
        () => _MedicationAccumulator(displayName),
      );
      accumulator.intakeCount++;
      final migraine = migrainesById[intake.symptomId];
      if (migraine == null) continue;
      accumulator.linkedMigraineIds.add(migraine.id);
      final start = migraine.startedAt;
      if (start != null && !intake.timestamp.isBefore(start)) {
        accumulator.delays.add(intake.timestamp.difference(start));
      }
    }

    final stats =
        [
          for (final accumulator in grouped.values)
            MedicationStats(
              name: accumulator.name,
              intakeCount: accumulator.intakeCount,
              linkedMigraineCount: accumulator.linkedMigraineIds.length,
              averageDelayAfterMigraineStart: accumulator.delays.isEmpty
                  ? null
                  : Duration(
                      microseconds:
                          accumulator.delays.fold<int>(
                            0,
                            (sum, delay) => sum + delay.inMicroseconds,
                          ) ~/
                          accumulator.delays.length,
                    ),
            ),
        ]..sort((first, second) {
          final byCount = second.intakeCount.compareTo(first.intakeCount);
          return byCount != 0
              ? byCount
              : first.name.toLowerCase().compareTo(second.name.toLowerCase());
        });
    return stats;
  }
}

class _MedicationAccumulator {
  _MedicationAccumulator(this.name);

  final String name;
  int intakeCount = 0;
  final Set<String> linkedMigraineIds = {};
  final List<Duration> delays = [];
}
