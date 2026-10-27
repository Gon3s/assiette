enum TagMergeError { sameTag, missing }

class TagMergeException implements Exception {
  const TagMergeException(this.reason);

  final TagMergeError reason;
}
