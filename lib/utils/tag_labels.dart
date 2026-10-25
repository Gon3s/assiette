/// Collapses whitespace while preserving the user's spelling and accents.
String normalizeTagLabel(String label) =>
    label.trim().replaceAll(RegExp(r'\s+'), ' ');

enum TagLabelError { empty, duplicate, missing }

class TagLabelException implements Exception {
  const TagLabelException(this.reason);

  final TagLabelError reason;
}
