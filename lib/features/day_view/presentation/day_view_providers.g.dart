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
