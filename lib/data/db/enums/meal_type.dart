enum MealType { breakfast, lunch, dinner, snack }

/// Pre-selects the meal type most likely at [time] (local).
MealType defaultMealTypeFor(DateTime time) {
  final hour = time.hour;
  if (hour < 11) return MealType.breakfast;
  if (hour < 14) return MealType.lunch;
  if (hour < 18) return MealType.snack;
  return MealType.dinner;
}
