import 'package:assiette/features/meal_entry/data/photo_tag_suggestion_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_tag_suggestion_service.g.dart';

/// Suggests candidate tag labels from a meal photo (US-19). Suggestions are
/// a convenience only - the user always confirms or corrects them, never
/// auto-applied.
// Deliberate single-method contract so tests can mock the ML Kit call.
// ignore: one_member_abstracts
abstract class PhotoTagSuggestionService {
  /// Returns candidate labels detected in the photo at [photoPath], most
  /// confident first. Returns an empty list on failure (e.g. no model
  /// available) rather than throwing, since this is a best-effort feature.
  Future<List<String>> suggestLabels(String photoPath);
}

/// Provides the [PhotoTagSuggestionService] implementation.
@riverpod
PhotoTagSuggestionService photoTagSuggestionService(Ref ref) =>
    MlKitPhotoTagSuggestionService();
