// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_view_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The merged, time-sorted timeline (meals + symptoms) for [date].

@ProviderFor(dayTimeline)
final dayTimelineProvider = DayTimelineFamily._();

/// The merged, time-sorted timeline (meals + symptoms) for [date].

final class DayTimelineProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TimelineItem>>,
          List<TimelineItem>,
          Stream<List<TimelineItem>>
        >
    with
        $FutureModifier<List<TimelineItem>>,
        $StreamProvider<List<TimelineItem>> {
  /// The merged, time-sorted timeline (meals + symptoms) for [date].
  DayTimelineProvider._({
    required DayTimelineFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'dayTimelineProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dayTimelineHash();

  @override
  String toString() {
    return r'dayTimelineProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<TimelineItem>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TimelineItem>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return dayTimeline(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DayTimelineProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dayTimelineHash() => r'506897155db85e319cabd0cd2ae6900256e4ddb4';

/// The merged, time-sorted timeline (meals + symptoms) for [date].

final class DayTimelineFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<TimelineItem>>, DateTime> {
  DayTimelineFamily._()
    : super(
        retry: null,
        name: r'dayTimelineProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The merged, time-sorted timeline (meals + symptoms) for [date].

  DayTimelineProvider call(DateTime date) =>
      DayTimelineProvider._(argument: date, from: this);

  @override
  String toString() => r'dayTimelineProvider';
}

/// Non-timed physical feelings and mood for [date].

@ProviderFor(dayFeelings)
final dayFeelingsProvider = DayFeelingsFamily._();

/// Non-timed physical feelings and mood for [date].

final class DayFeelingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DailyFeeling>>,
          List<DailyFeeling>,
          Stream<List<DailyFeeling>>
        >
    with
        $FutureModifier<List<DailyFeeling>>,
        $StreamProvider<List<DailyFeeling>> {
  /// Non-timed physical feelings and mood for [date].
  DayFeelingsProvider._({
    required DayFeelingsFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'dayFeelingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dayFeelingsHash();

  @override
  String toString() {
    return r'dayFeelingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<DailyFeeling>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DailyFeeling>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return dayFeelings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DayFeelingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dayFeelingsHash() => r'bb4b267f4322228505a34503d0c7cad94fd8ec7f';

/// Non-timed physical feelings and mood for [date].

final class DayFeelingsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<DailyFeeling>>, DateTime> {
  DayFeelingsFamily._()
    : super(
        retry: null,
        name: r'dayFeelingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Non-timed physical feelings and mood for [date].

  DayFeelingsProvider call(DateTime date) =>
      DayFeelingsProvider._(argument: date, from: this);

  @override
  String toString() => r'dayFeelingsProvider';
}

/// The currently unfinished migraine, independently of the selected day.

@ProviderFor(activeMigraine)
final activeMigraineProvider = ActiveMigraineProvider._();

/// The currently unfinished migraine, independently of the selected day.

final class ActiveMigraineProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActiveMigraine?>,
          ActiveMigraine?,
          Stream<ActiveMigraine?>
        >
    with $FutureModifier<ActiveMigraine?>, $StreamProvider<ActiveMigraine?> {
  /// The currently unfinished migraine, independently of the selected day.
  ActiveMigraineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeMigraineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeMigraineHash();

  @$internal
  @override
  $StreamProviderElement<ActiveMigraine?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ActiveMigraine?> create(Ref ref) {
    return activeMigraine(ref);
  }
}

String _$activeMigraineHash() => r'3804a2abbe635cc3e7594cbd4836aa86b0fa0722';

/// The sleep entry for [date]'s night, if logged.

@ProviderFor(daySleep)
final daySleepProvider = DaySleepFamily._();

/// The sleep entry for [date]'s night, if logged.

final class DaySleepProvider
    extends
        $FunctionalProvider<
          AsyncValue<SleepSummary?>,
          SleepSummary?,
          Stream<SleepSummary?>
        >
    with $FutureModifier<SleepSummary?>, $StreamProvider<SleepSummary?> {
  /// The sleep entry for [date]'s night, if logged.
  DaySleepProvider._({
    required DaySleepFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'daySleepProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$daySleepHash();

  @override
  String toString() {
    return r'daySleepProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<SleepSummary?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<SleepSummary?> create(Ref ref) {
    final argument = this.argument as DateTime;
    return daySleep(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DaySleepProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$daySleepHash() => r'95f606e7ec80171a1b6d257f144240774266c033';

/// The sleep entry for [date]'s night, if logged.

final class DaySleepFamily extends $Family
    with $FunctionalFamilyOverride<Stream<SleepSummary?>, DateTime> {
  DaySleepFamily._()
    : super(
        retry: null,
        name: r'daySleepProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The sleep entry for [date]'s night, if logged.

  DaySleepProvider call(DateTime date) =>
      DaySleepProvider._(argument: date, from: this);

  @override
  String toString() => r'daySleepProvider';
}

/// The latest weather/pressure snapshot captured on [date].

@ProviderFor(dayWeather)
final dayWeatherProvider = DayWeatherFamily._();

/// The latest weather/pressure snapshot captured on [date].

final class DayWeatherProvider
    extends
        $FunctionalProvider<
          AsyncValue<WeatherSummary?>,
          WeatherSummary?,
          Stream<WeatherSummary?>
        >
    with $FutureModifier<WeatherSummary?>, $StreamProvider<WeatherSummary?> {
  /// The latest weather/pressure snapshot captured on [date].
  DayWeatherProvider._({
    required DayWeatherFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'dayWeatherProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dayWeatherHash();

  @override
  String toString() {
    return r'dayWeatherProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<WeatherSummary?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<WeatherSummary?> create(Ref ref) {
    final argument = this.argument as DateTime;
    return dayWeather(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DayWeatherProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dayWeatherHash() => r'61facda0cb5c3704b0f3d2868b690b081d4e718e';

/// The latest weather/pressure snapshot captured on [date].

final class DayWeatherFamily extends $Family
    with $FunctionalFamilyOverride<Stream<WeatherSummary?>, DateTime> {
  DayWeatherFamily._()
    : super(
        retry: null,
        name: r'dayWeatherProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The latest weather/pressure snapshot captured on [date].

  DayWeatherProvider call(DateTime date) =>
      DayWeatherProvider._(argument: date, from: this);

  @override
  String toString() => r'dayWeatherProvider';
}

/// The full measured weather series for [date] (charts).

@ProviderFor(dayWeatherSeries)
final dayWeatherSeriesProvider = DayWeatherSeriesFamily._();

/// The full measured weather series for [date] (charts).

final class DayWeatherSeriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WeatherPoint>>,
          List<WeatherPoint>,
          Stream<List<WeatherPoint>>
        >
    with
        $FutureModifier<List<WeatherPoint>>,
        $StreamProvider<List<WeatherPoint>> {
  /// The full measured weather series for [date] (charts).
  DayWeatherSeriesProvider._({
    required DayWeatherSeriesFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'dayWeatherSeriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dayWeatherSeriesHash();

  @override
  String toString() {
    return r'dayWeatherSeriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<WeatherPoint>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<WeatherPoint>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return dayWeatherSeries(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DayWeatherSeriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dayWeatherSeriesHash() => r'72657c42e9c9274e76dce41f72c1b216a48ddcae';

/// The full measured weather series for [date] (charts).

final class DayWeatherSeriesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<WeatherPoint>>, DateTime> {
  DayWeatherSeriesFamily._()
    : super(
        retry: null,
        name: r'dayWeatherSeriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The full measured weather series for [date] (charts).

  DayWeatherSeriesProvider call(DateTime date) =>
      DayWeatherSeriesProvider._(argument: date, from: this);

  @override
  String toString() => r'dayWeatherSeriesProvider';
}

/// Resolves place names from coordinates; kept alive so its per-location
/// memoization survives day changes.

@ProviderFor(localityResolver)
final localityResolverProvider = LocalityResolverProvider._();

/// Resolves place names from coordinates; kept alive so its per-location
/// memoization survives day changes.

final class LocalityResolverProvider
    extends
        $FunctionalProvider<
          LocalityResolver,
          LocalityResolver,
          LocalityResolver
        >
    with $Provider<LocalityResolver> {
  /// Resolves place names from coordinates; kept alive so its per-location
  /// memoization survives day changes.
  LocalityResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localityResolverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localityResolverHash();

  @$internal
  @override
  $ProviderElement<LocalityResolver> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalityResolver create(Ref ref) {
    return localityResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalityResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalityResolver>(value),
    );
  }
}

String _$localityResolverHash() => r'2429b8aeef4f68c904b6253b2dd0143ad0843de1';

/// The place name (city) of the selected day's latest snapshot, or `null`
/// when unknown.

@ProviderFor(dayLocality)
final dayLocalityProvider = DayLocalityFamily._();

/// The place name (city) of the selected day's latest snapshot, or `null`
/// when unknown.

final class DayLocalityProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// The place name (city) of the selected day's latest snapshot, or `null`
  /// when unknown.
  DayLocalityProvider._({
    required DayLocalityFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'dayLocalityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dayLocalityHash();

  @override
  String toString() {
    return r'dayLocalityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    final argument = this.argument as DateTime;
    return dayLocality(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DayLocalityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dayLocalityHash() => r'9569a78c39139962fbd817ab32d8d01dfb852b9f';

/// The place name (city) of the selected day's latest snapshot, or `null`
/// when unknown.

final class DayLocalityFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String?>, DateTime> {
  DayLocalityFamily._()
    : super(
        retry: null,
        name: r'dayLocalityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The place name (city) of the selected day's latest snapshot, or `null`
  /// when unknown.

  DayLocalityProvider call(DateTime date) =>
      DayLocalityProvider._(argument: date, from: this);

  @override
  String toString() => r'dayLocalityProvider';
}

/// Hourly pressure forecast (today + tomorrow) at the selected day's
/// snapshot location; empty when no coordinates are known.

@ProviderFor(dayPressureForecast)
final dayPressureForecastProvider = DayPressureForecastFamily._();

/// Hourly pressure forecast (today + tomorrow) at the selected day's
/// snapshot location; empty when no coordinates are known.

final class DayPressureForecastProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HourlyMeasure>>,
          List<HourlyMeasure>,
          FutureOr<List<HourlyMeasure>>
        >
    with
        $FutureModifier<List<HourlyMeasure>>,
        $FutureProvider<List<HourlyMeasure>> {
  /// Hourly pressure forecast (today + tomorrow) at the selected day's
  /// snapshot location; empty when no coordinates are known.
  DayPressureForecastProvider._({
    required DayPressureForecastFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'dayPressureForecastProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dayPressureForecastHash();

  @override
  String toString() {
    return r'dayPressureForecastProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<HourlyMeasure>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HourlyMeasure>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return dayPressureForecast(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DayPressureForecastProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dayPressureForecastHash() =>
    r'a7a410e8fa1dd69bfb11e7101deea07b84264cef';

/// Hourly pressure forecast (today + tomorrow) at the selected day's
/// snapshot location; empty when no coordinates are known.

final class DayPressureForecastFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<HourlyMeasure>>, DateTime> {
  DayPressureForecastFamily._()
    : super(
        retry: null,
        name: r'dayPressureForecastProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Hourly pressure forecast (today + tomorrow) at the selected day's
  /// snapshot location; empty when no coordinates are known.

  DayPressureForecastProvider call(DateTime date) =>
      DayPressureForecastProvider._(argument: date, from: this);

  @override
  String toString() => r'dayPressureForecastProvider';
}
