/// Summary of the single currently active migraine episode.
class ActiveMigraine {
  const ActiveMigraine({
    required this.id,
    required this.startedAt,
    required this.lastIntensity,
  });

  final String id;
  final DateTime? startedAt;
  final int lastIntensity;
}
