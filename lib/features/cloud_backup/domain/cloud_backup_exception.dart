/// Raised by the cloud backup repository on sign-in, backup, or restore
/// failures (network, auth, or missing remote backup) so callers can show
/// a clear message instead of a raw stack trace.
class CloudBackupException implements Exception {
  /// Creates a [CloudBackupException] with a diagnostic [message].
  CloudBackupException(this.message, {this.isNotFound = false});

  /// A short, non-localized description of what went wrong (for logs —
  /// callers should show their own localized message to users).
  final String message;

  /// Whether this specifically means "no backup exists for this account",
  /// as opposed to a network/auth failure — callers use this to pick
  /// between "nothing to restore" and "something went wrong" messaging.
  final bool isNotFound;

  @override
  String toString() => message;
}
