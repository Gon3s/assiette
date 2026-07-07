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
  }) = _WeatherSummary;
}
