/// The journal day of a night: evening bedtimes belong to the next day.
/// The noon boundary also keeps repeated taps across midnight on the same night.
DateTime sleepDayForBedTime(DateTime bedTime) {
  final local = bedTime.toLocal();
  return DateTime(
    local.year,
    local.month,
    local.day + (local.hour >= 12 ? 1 : 0),
  );
}
