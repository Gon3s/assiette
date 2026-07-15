import 'package:assiette/features/meal_entry/data/meal_photo_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meal_photo_service.g.dart';

/// Captures a meal photo and stores it in the app's internal storage.
// Deliberate single-method contract so tests can mock the camera flow.
// ignore: one_member_abstracts
abstract class MealPhotoService {
  /// Opens the camera; on success copies the shot into the app documents
  /// directory and returns the stored path. Returns null when the user
  /// cancels.
  Future<String?> captureFromCamera();
}

/// Provides the [MealPhotoService] implementation.
@riverpod
MealPhotoService mealPhotoService(Ref ref) => ImagePickerMealPhotoService();
