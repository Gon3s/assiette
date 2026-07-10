import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_meteo_reading.freezed.dart';

/// A single current-conditions reading returned by the Open-Meteo API.
@freezed
abstract class OpenMeteoReading with _$OpenMeteoReading {
  /// Creates an [OpenMeteoReading].
  const factory OpenMeteoReading({
    double? pressure,
    double? surfacePressure,
    double? temperature,
    double? humidity,
  }) = _OpenMeteoReading;
}
