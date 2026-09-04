// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_view_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The merged, time-sorted timeline (meals + symptoms) for the selected day.

@ProviderFor(dayTimeline)
final dayTimelineProvider = DayTimelineProvider._();

/// The merged, time-sorted timeline (meals + symptoms) for the selected day.

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
  /// The merged, time-sorted timeline (meals + symptoms) for the selected day.
  DayTimelineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dayTimelineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dayTimelineHash();

  @$internal
  @override
  $StreamProviderElement<List<TimelineItem>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TimelineItem>> create(Ref ref) {
    return dayTimeline(ref);
  }
}

String _$dayTimelineHash() => r'12e8ffb99dc444d37bcd1037977032aa77466eeb';

/// Non-timed physical feelings and mood for the selected day.

@ProviderFor(dayFeelings)
final dayFeelingsProvider = DayFeelingsProvider._();

/// Non-timed physical feelings and mood for the selected day.

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
  /// Non-timed physical feelings and mood for the selected day.
  DayFeelingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dayFeelingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dayFeelingsHash();

  @$internal
  @override
  $StreamProviderElement<List<DailyFeeling>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DailyFeeling>> create(Ref ref) {
    return dayFeelings(ref);
  }
}

String _$dayFeelingsHash() => r'5690c08da6e5e87c631b1bd2030798e5a385101f';

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

/// The sleep entry for the selected day's night, if logged.

@ProviderFor(daySleep)
final daySleepProvider = DaySleepProvider._();

/// The sleep entry for the selected day's night, if logged.

final class DaySleepProvider
    extends
        $FunctionalProvider<
          AsyncValue<SleepSummary?>,
          SleepSummary?,
          Stream<SleepSummary?>
        >
    with $FutureModifier<SleepSummary?>, $StreamProvider<SleepSummary?> {
  /// The sleep entry for the selected day's night, if logged.
  DaySleepProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'daySleepProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$daySleepHash();

  @$internal
  @override
  $StreamProviderElement<SleepSummary?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<SleepSummary?> create(Ref ref) {
    return daySleep(ref);
  }
}

String _$daySleepHash() => r'1d103d8297e541b56e1860697e4e3d632293cca2';

/// The latest weather/pressure snapshot captured on the selected day.

@ProviderFor(dayWeather)
final dayWeatherProvider = DayWeatherProvider._();

/// The latest weather/pressure snapshot captured on the selected day.

final class DayWeatherProvider
    extends
        $FunctionalProvider<
          AsyncValue<WeatherSummary?>,
          WeatherSummary?,
          Stream<WeatherSummary?>
        >
    with $FutureModifier<WeatherSummary?>, $StreamProvider<WeatherSummary?> {
  /// The latest weather/pressure snapshot captured on the selected day.
  DayWeatherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dayWeatherProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dayWeatherHash();

  @$internal
  @override
  $StreamProviderElement<WeatherSummary?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<WeatherSummary?> create(Ref ref) {
    return dayWeather(ref);
  }
}

String _$dayWeatherHash() => r'618d127c563f0477e638422b21013886924618a4';

/// The full measured weather series for the selected day (charts).

@ProviderFor(dayWeatherSeries)
final dayWeatherSeriesProvider = DayWeatherSeriesProvider._();

/// The full measured weather series for the selected day (charts).

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
  /// The full measured weather series for the selected day (charts).
  DayWeatherSeriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dayWeatherSeriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dayWeatherSeriesHash();

  @$internal
  @override
  $StreamProviderElement<List<WeatherPoint>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<WeatherPoint>> create(Ref ref) {
    return dayWeatherSeries(ref);
  }
}

String _$dayWeatherSeriesHash() => r'f9b04575caa7e799b7c90d74b6698e5dfe968fc7';

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
final dayLocalityProvider = DayLocalityProvider._();

/// The place name (city) of the selected day's latest snapshot, or `null`
/// when unknown.

final class DayLocalityProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// The place name (city) of the selected day's latest snapshot, or `null`
  /// when unknown.
  DayLocalityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dayLocalityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dayLocalityHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return dayLocality(ref);
  }
}

String _$dayLocalityHash() => r'99e44b415e2ad2a708132eb3bd33b0ac77631f50';

/// Hourly pressure forecast (today + tomorrow) at the selected day's
/// snapshot location; empty when no coordinates are known.

@ProviderFor(dayPressureForecast)
final dayPressureForecastProvider = DayPressureForecastProvider._();

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
  DayPressureForecastProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dayPressureForecastProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dayPressureForecastHash();

  @$internal
  @override
  $FutureProviderElement<List<HourlyMeasure>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HourlyMeasure>> create(Ref ref) {
    return dayPressureForecast(ref);
  }
}

String _$dayPressureForecastHash() =>
    r'ce6f00a6cf6e9de9331534309bc89e2d2130f20d';
