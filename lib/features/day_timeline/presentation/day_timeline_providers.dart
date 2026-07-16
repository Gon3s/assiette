import 'dart:async';

import 'package:assiette/data/daos/meals_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/day_timeline/domain/timeline_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _SelectedDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  DateTime get selectedDate => state;
  set selectedDate(DateTime date) => state = date;
}

final selectedDateProvider = NotifierProvider<_SelectedDateNotifier, DateTime>(
  _SelectedDateNotifier.new,
);

final StreamProvider<List<TimelineItem>> dayTimelineProvider =
    StreamProvider.autoDispose<List<TimelineItem>>((ref) {
  final date = ref.watch(selectedDateProvider);
  final db = ref.watch(appDatabaseProvider);
  final controller = StreamController<List<TimelineItem>>();
  List<MealWithTags>? meals;
  List<Symptom>? symptoms;

  void emit() {
    if (meals == null || symptoms == null) return;
    final items = <TimelineItem>[
      ...meals!.map((m) => MealItem(meal: m.meal, tags: m.tags)),
      ...symptoms!.map((s) => SymptomItem(symptom: s)),
    ]..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    controller.add(items);
  }

  final mealsSub = db.mealsDao.watchByDayWithTags(date).listen((data) {
    meals = data;
    emit();
  });
  final symptomsSub = db.symptomsDao.watchByDay(date).listen((data) {
    symptoms = data;
    emit();
  });

  ref.onDispose(() {
    unawaited(mealsSub.cancel());
    unawaited(symptomsSub.cancel());
    unawaited(controller.close());
  });

  return controller.stream;
});

final StreamProvider<EnvironmentSnapshot?> latestEnvForDayProvider =
    StreamProvider.autoDispose<EnvironmentSnapshot?>((ref) {
  final date = ref.watch(selectedDateProvider);
  final db = ref.watch(appDatabaseProvider);
  return db.environmentDao
      .watchByDay(date)
      .map((list) => list.isEmpty ? null : list.last);
});

final StreamProvider<SleepEntry?> sleepForDayProvider =
    StreamProvider.autoDispose<SleepEntry?>((ref) {
  final date = ref.watch(selectedDateProvider);
  final db = ref.watch(appDatabaseProvider);
  return db.sleepEntriesDao.watchByDate(date);
});
