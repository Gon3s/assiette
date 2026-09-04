/// How precisely the real start of a migraine episode is known.
enum MigraineStartPrecision {
  /// The user confirmed the start instant.
  exact,

  /// The start instant is an estimate.
  approximate,

  /// No usable start instant is known.
  unknown,
}
