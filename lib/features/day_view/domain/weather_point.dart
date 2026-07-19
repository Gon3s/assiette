import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_point.freezed.dart';

/// One point of the day's measured weather series, feeding the
/// temperature/pressure evolution charts.
@freezed
abstract class WeatherPoint with _$WeatherPoint {
  /// Creates a [WeatherPoint].
  const factory WeatherPoint({
    required DateTime timestamp,
    double? temperature,
    double? pressure,
  }) = _WeatherPoint;
}
