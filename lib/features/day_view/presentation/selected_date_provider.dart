import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_date_provider.g.dart';

/// The day currently shown by the day view screen. Defaults to today.
///
/// Day navigation (US-11) will call [select] / [goToToday] to change it.
@riverpod
class SelectedDate extends _$SelectedDate {
  @override
  DateTime build() => _today();

  /// Selects an arbitrary [date] (normalized to midnight).
  void select(DateTime date) =>
      state = DateTime(date.year, date.month, date.day);

  /// Returns to the current day.
  void goToToday() => state = _today();

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
