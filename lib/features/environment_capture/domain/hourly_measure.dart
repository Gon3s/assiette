import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourly_measure.freezed.dart';

/// A single timestamped value of an hourly forecast series.
@freezed
abstract class HourlyMeasure with _$HourlyMeasure {
  /// Creates an [HourlyMeasure].
  const factory HourlyMeasure({
    required DateTime time,
    required double value,
  }) = _HourlyMeasure;
}
