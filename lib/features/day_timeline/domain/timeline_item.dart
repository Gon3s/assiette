// ignore_for_file: public_member_api_docs
import 'package:assiette/data/db/app_database.dart';

sealed class TimelineItem {
  DateTime get timestamp;
}

final class MealItem extends TimelineItem {
  MealItem({required this.meal, required this.tags});
  final Meal meal;
  final List<Tag> tags;

  @override
  DateTime get timestamp => meal.timestamp;
}

final class SymptomItem extends TimelineItem {
  SymptomItem({required this.symptom});
  final Symptom symptom;

  @override
  DateTime get timestamp => symptom.timestamp;
}
