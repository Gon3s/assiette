import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_meteo_hourly_history.freezed.dart';

/// Hourly weather series returned by the Open-Meteo forecast API, used to
/// backfill days where no snapshot was captured (phone off, task killed...).
///
/// All lists are parallel to [times]; a `null` means the value was missing
/// for that hour.
@freezed
abstract class OpenMeteoHourlyHistory with _$OpenMeteoHourlyHistory {
  /// Creates an [OpenMeteoHourlyHistory].
  const factory OpenMeteoHourlyHistory({
    required List<DateTime> times,
    required List<double?> pressure,
    required List<double?> temperature,
    required List<double?> humidity,
    required List<int?> weatherCode,
    required List<double?> uvIndex,
  }) = _OpenMeteoHourlyHistory;
}
