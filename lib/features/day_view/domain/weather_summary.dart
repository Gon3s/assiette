import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_summary.freezed.dart';

/// The most recent weather/pressure snapshot captured for a given day.
@freezed
abstract class WeatherSummary with _$WeatherSummary {
  /// Creates a [WeatherSummary].
  const factory WeatherSummary({
    required DateTime timestamp,
    double? pressure,
    double? pressureDelta,
    double? temperature,
    double? humidity,
    double? lat,
    double? lon,
    int? weatherCode,
    double? uvIndex,
    double? pm25,
    double? pm10,

    /// Highest pollen concentration (grains/m³) across the tracked
    /// species, or `null` when no pollen data is available.
    double? pollenMax,
  }) = _WeatherSummary;
}
