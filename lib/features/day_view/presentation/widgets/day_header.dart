import 'dart:math' as math;

import 'package:assiette/constants/app_colors.dart';
import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/widgets/weather_chart_sheet.dart';
import 'package:assiette/features/day_view/presentation/widgets/weather_code_icon.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Header of the day view: latest weather captured for the day (place,
/// freshness, condition icon) and a vertically paged row of metrics.
/// Temperature and pressure open the day-evolution chart sheet.
class DayHeader extends ConsumerWidget {
  /// Creates a [DayHeader].
  const DayHeader({required this.date, super.key});

  /// Day whose environment data is displayed.
  final DateTime date;

  /// Pollen concentration (grains/m³) below which the level reads "low",
  /// and above five times which it reads "high".
  static const _pollenLowThreshold = 10.0;
  static const _pollenHighThreshold = 50.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final weather = ref.watch(dayWeatherProvider(date)).value;
    final theme = Theme.of(context);

    if (weather == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.p16,
          vertical: Sizes.p8,
        ),
        child: Row(
          children: [
            Icon(Icons.cloud_off, size: Sizes.p16, color: theme.hintColor),
            gapW8,
            Expanded(
              child: Text(
                s.weatherUnavailable,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    final locality = ref.watch(dayLocalityProvider(date)).value;
    final weatherCode = weather.weatherCode;
    final updatedLabel = _updatedLabel(s, date, weather.timestamp);

    final temperature = weather.temperature;
    final pressure = weather.pressure;
    final delta = weather.pressureDelta;
    final humidity = weather.humidity;
    final uvIndex = weather.uvIndex;
    final pollenMax = weather.pollenMax;
    final pm25 = weather.pm25;
    final pm10 = weather.pm10;

    final tiles = <_WeatherMetricRow>[
      if (temperature != null)
        _WeatherMetricRow(
          label: s.weatherTemperatureLabel,
          value: '${temperature.round()}°C',
          onTap: () => showWeatherChartSheet(
            context,
            WeatherChartKind.temperature,
            date,
          ),
        ),
      if (pressure != null)
        _WeatherMetricRow(
          label: s.weatherPressureLabel,
          value: '${pressure.round()} ${s.pressureUnit}',
          trailing: delta == null || delta == 0
              ? null
              : Icon(
                  delta > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  size: Sizes.p16,
                  color: delta > 0 ? AppColors.turquoise : AppColors.alert,
                ),
          onTap: () => showWeatherChartSheet(
            context,
            WeatherChartKind.pressure,
            date,
          ),
        ),
      if (humidity != null)
        _WeatherMetricRow(
          label: s.weatherHumidityLabel,
          value: '${humidity.round()} %',
        ),
      if (uvIndex != null)
        _WeatherMetricRow(
          label: s.weatherUvLabel,
          value: '${uvIndex.round()}',
        ),
      if (pollenMax != null)
        _WeatherMetricRow(
          label: s.weatherPollenLabel,
          value: _pollenLevelLabel(s, pollenMax),
        ),
      if (pm25 != null)
        _WeatherMetricRow(
          label: s.weatherAirLabel,
          value: '${pm25.round()} ${s.airQualityUnit}',
        ),
      if (pm10 != null)
        _WeatherMetricRow(
          label: s.weatherAirPm10Label,
          value: '${pm10.round()} ${s.airQualityUnit}',
        ),
    ];

    final hasMetadata =
        locality != null || weatherCode != null || updatedLabel != null;
    if (tiles.isEmpty && !hasMetadata) return const SizedBox.shrink();

    final metadata = [?locality, ?updatedLabel].join(' · ');

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p8,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Row(
          children: [
            Tooltip(
              message: metadata,
              triggerMode: TooltipTriggerMode.tap,
              child: SizedBox.square(
                dimension: Sizes.p48,
                child: Icon(
                  weatherCode == null
                      ? Icons.cloud_outlined
                      : weatherCodeIcon(weatherCode),
                  size: Sizes.p20,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            if (tiles.isNotEmpty)
              Expanded(
                child: _WeatherPager(
                  key: ValueKey((date, tiles.map((tile) => tile.label).join())),
                  tiles: tiles,
                ),
              )
            else
              Expanded(
                child: Text(
                  metadata,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Freshness of the snapshot, only meaningful while looking at today.
  static String? _updatedLabel(
    AppStrings s,
    DateTime date,
    DateTime timestamp,
  ) {
    final now = DateTime.now();
    if (date.year != now.year ||
        date.month != now.month ||
        date.day != now.day) {
      return null;
    }
    final elapsed = DateTime.now().difference(timestamp.toUtc());
    if (elapsed > const Duration(hours: 24)) return null;
    if (elapsed < const Duration(minutes: 1)) return s.weatherUpdatedJustNow;
    if (elapsed < const Duration(hours: 1)) {
      return s.weatherUpdatedMinutesAgo(elapsed.inMinutes);
    }
    return s.weatherUpdatedHoursAgo(elapsed.inHours);
  }

  static String _pollenLevelLabel(AppStrings s, double pollen) {
    if (pollen < _pollenLowThreshold) return s.pollenLevelLow;
    if (pollen < _pollenHighThreshold) return s.pollenLevelModerate;
    return s.pollenLevelHigh;
  }
}

class _WeatherPager extends StatefulWidget {
  const _WeatherPager({required this.tiles, super.key});

  final List<_WeatherMetricRow> tiles;

  @override
  State<_WeatherPager> createState() => _WeatherPagerState();
}

class _WeatherPagerState extends State<_WeatherPager> {
  final _controller = PageController();
  var _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextMetric() {
    final next = (_page + 1) % widget.tiles.length;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.jumpToPage(next);
    } else {
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final style = Theme.of(context).textTheme.bodyMedium!;
    final height = math.max(
      Sizes.p48,
      MediaQuery.textScalerOf(context).scale(style.fontSize!) *
              (style.height ?? 1.5) +
          Sizes.p24,
    );
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: widget.tiles.length == 1
                ? widget.tiles.single
                : PageView.builder(
                    key: const Key('weather-metrics'),
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    allowImplicitScrolling: true,
                    itemCount: widget.tiles.length,
                    onPageChanged: (page) => setState(() => _page = page),
                    itemBuilder: (context, index) => widget.tiles[index],
                  ),
          ),
          if (widget.tiles.length > 1)
            IconButton(
              tooltip:
                  '${s.weatherNextMetric} '
                  '(${_page + 1}/${widget.tiles.length})',
              onPressed: _nextMetric,
              icon: const Icon(Icons.swap_vert, size: Sizes.p20),
            )
          else
            gapW12,
        ],
      ),
    );
  }
}

class _WeatherMetricRow extends StatelessWidget {
  const _WeatherMetricRow({
    required this.label,
    required this.value,
    this.trailing,
    this.onTap,
  });

  final String label;
  final String value;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          gapW8,
          Flexible(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailing != null) ...[gapW4, trailing!],
        ],
      ),
    );
  }
}
