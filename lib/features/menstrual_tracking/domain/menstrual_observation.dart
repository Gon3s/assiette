import 'package:freezed_annotation/freezed_annotation.dart';

part 'menstrual_observation.freezed.dart';

enum BleedingStatus { none, spotting, period }

enum MenstrualFlow { light, medium, heavy }

@freezed
abstract class MenstrualObservation with _$MenstrualObservation {
  const factory MenstrualObservation({
    required String localDate,
    required BleedingStatus status,
    MenstrualFlow? flow,
    @Default(false) bool isPeriodStart,
    String? note,
  }) = _MenstrualObservation;
}

@freezed
abstract class MenstrualPreferences with _$MenstrualPreferences {
  const factory MenstrualPreferences({
    @Default(false) bool enabled,
    @Default(false) bool includeInBackup,
    @Default(false) bool includeInPdf,
  }) = _MenstrualPreferences;
}

String menstrualDateKey(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

DateTime parseMenstrualDate(String key) {
  final date = DateTime.tryParse(key);
  if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(key) ||
      date == null ||
      date.year < 1 ||
      menstrualDateKey(date) != key) {
    throw const FormatException('Invalid calendar date');
  }
  return date;
}

void validateMenstrualObservation(MenstrualObservation observation) {
  parseMenstrualDate(observation.localDate);
  if (observation.status != BleedingStatus.period &&
      (observation.flow != null || observation.isPeriodStart)) {
    throw const FormatException('Flow and start require a period');
  }
  if ((observation.note?.length ?? 0) > 2000) {
    throw const FormatException('Note exceeds 2000 characters');
  }
}
