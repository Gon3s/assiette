import 'package:assiette/features/meal_entry/domain/photo_tag_suggestion_service.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

/// [PhotoTagSuggestionService] using ML Kit's on-device image labeling
/// (base model, bundled with the app - no network call, no photo leaves the
/// device).
class MlKitPhotoTagSuggestionService implements PhotoTagSuggestionService {
  static const _confidenceThreshold = 0.6;
  static const _maxLabels = 5;

  @override
  Future<List<String>> suggestLabels(String photoPath) async {
    final labeler = ImageLabeler(
      options: ImageLabelerOptions(confidenceThreshold: _confidenceThreshold),
    );
    try {
      final labels = await labeler.processImage(
        InputImage.fromFilePath(photoPath),
      );
      labels.sort((a, b) => b.confidence.compareTo(a.confidence));
      return [for (final label in labels.take(_maxLabels)) label.label];
    } on Exception {
      return const [];
    } finally {
      await labeler.close();
    }
  }
}
