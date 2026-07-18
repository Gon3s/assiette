import 'package:assiette/data/db/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_tag_suggestions_setting.g.dart';

/// Whether photo-based tag suggestions (US-19) are enabled. Defaults to
/// `true` until the user opts out in settings.
@riverpod
Stream<bool> photoTagSuggestionsEnabled(Ref ref) => ref
    .watch(appDatabaseProvider)
    .appSettingsDao
    .watchPhotoTagSuggestionsEnabled();

/// Persists the photo tag suggestions toggle (US-19).
@riverpod
class PhotoTagSuggestionsSettingController extends _$PhotoTagSuggestionsSettingController {
  @override
  void build() {}

  /// Enables/disables photo tag suggestions.
  Future<void> setEnabled({required bool enabled}) => ref
      .read(appDatabaseProvider)
      .appSettingsDao
      .setPhotoTagSuggestionsEnabled(enabled: enabled);
}
