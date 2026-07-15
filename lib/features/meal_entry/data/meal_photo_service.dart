import 'dart:io';

import 'package:assiette/features/meal_entry/domain/meal_photo_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// [MealPhotoService] using image_picker (camera) + path_provider storage.
class ImagePickerMealPhotoService implements MealPhotoService {
  /// Creates an [ImagePickerMealPhotoService]. [picker] is injectable for
  /// tests.
  ImagePickerMealPhotoService({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  static const _uuid = Uuid();

  @override
  Future<String?> captureFromCamera() async {
    final shot = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (shot == null) return null;

    final documentsDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory(p.join(documentsDir.path, 'meal_photos'));
    if (!photosDir.existsSync()) {
      photosDir.createSync(recursive: true);
    }
    final storedPath = p.join(
      photosDir.path,
      '${_uuid.v4()}${p.extension(shot.path)}',
    );
    await shot.saveTo(storedPath);
    return storedPath;
  }
}
