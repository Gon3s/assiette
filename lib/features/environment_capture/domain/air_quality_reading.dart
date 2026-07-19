import 'package:freezed_annotation/freezed_annotation.dart';

part 'air_quality_reading.freezed.dart';

/// A current air-quality reading returned by the Open-Meteo air-quality API.
///
/// Particulate matter is in µg/m³; pollen concentrations are in grains/m³
/// and only available over Europe.
@freezed
abstract class AirQualityReading with _$AirQualityReading {
  /// Creates an [AirQualityReading].
  const factory AirQualityReading({
    double? pm25,
    double? pm10,
    double? alderPollen,
    double? birchPollen,
    double? grassPollen,
    double? mugwortPollen,
    double? olivePollen,
    double? ragweedPollen,
  }) = _AirQualityReading;
}
