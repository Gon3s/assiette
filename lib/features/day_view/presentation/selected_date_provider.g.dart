// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_date_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The day currently shown by the day view screen. Defaults to today.
///
/// Day navigation (swipe, date picker, "today" shortcut) calls [select] /
/// [goToToday] to change it.

@ProviderFor(SelectedDate)
final selectedDateProvider = SelectedDateProvider._();

/// The day currently shown by the day view screen. Defaults to today.
///
/// Day navigation (swipe, date picker, "today" shortcut) calls [select] /
/// [goToToday] to change it.
final class SelectedDateProvider
    extends $NotifierProvider<SelectedDate, DateTime> {
  /// The day currently shown by the day view screen. Defaults to today.
  ///
  /// Day navigation (swipe, date picker, "today" shortcut) calls [select] /
  /// [goToToday] to change it.
  SelectedDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDateHash();

  @$internal
  @override
  SelectedDate create() => SelectedDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$selectedDateHash() => r'e6b39a2c59be83e0b19ebb8dcbd68049a05ca27d';

/// The day currently shown by the day view screen. Defaults to today.
///
/// Day navigation (swipe, date picker, "today" shortcut) calls [select] /
/// [goToToday] to change it.

abstract class _$SelectedDate extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
