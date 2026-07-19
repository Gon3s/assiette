import 'dart:math' as math;

import 'package:assiette/common_widgets/stat_tile_card.dart';
import 'package:assiette/constants/app_colors.dart';
import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/widgets/weather_chart_sheet.dart';
import 'package:assiette/features/day_view/presentation/widgets/weather_code_icon.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Header of the day view: latest weather captured for the day (place,
/// freshness, condition icon) and a grid of stat tiles. Temperature and
/// pressure tiles open the day-evolution chart sheet.
class DayHeader extends ConsumerWidget {
  /// Creates a [DayHeader].
  const DayHeader({super.key});

  /// Pollen concentration (grains/m³) below which the level reads "low",
  /// and above five times which it reads "high".
  static const _pollenLowThreshold = 10.0;
  static const _pollenHighThreshold = 50.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final weather = ref.watch(dayWeatherProvider).value;
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
            Text(
              s.weatherUnavailable,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.hintColor),
            ),
          ],
        ),
      );
    }

    final locality = ref.watch(dayLocalityProvider).value;
    final weatherCode = weather.weatherCode;
    final updatedLabel = _updatedLabel(s, weather.timestamp);

    final temperature = weather.temperature;
    final pressure = weather.pressure;
    final delta = weather.pressureDelta;
    final humidity = weather.humidity;
    final uvIndex = weather.uvIndex;
    final pollenMax = weather.pollenMax;
    final pm25 = weather.pm25;

    final tiles = <Widget>[
      if (temperature != null)
        StatTileCard(
          label: s.weatherTemperatureLabel,
          value: '${temperature.round()}°C',
          accent: AppColors.turquoise,
          onTap: () =>
              showWeatherChartSheet(context, WeatherChartKind.temperature),
        ),
      if (pressure != null)
        StatTileCard(
          label: s.weatherPressureLabel,
          value: '${pressure.round()} ${s.pressureUnit}',
          trailing: delta == null || delta == 0
              ? null
              : Icon(
                  delta > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  size: Sizes.p16,
                  color:
                      delta > 0 ? AppColors.turquoise : AppColors.alert,
                ),
          onTap: () =>
              showWeatherChartSheet(context, WeatherChartKind.pressure),
        ),
      if (humidity != null)
        StatTileCard(
          label: s.weatherHumidityLabel,
          value: '${humidity.round()} %',
        ),
      if (uvIndex != null)
        StatTileCard(
          label: s.weatherUvLabel,
          value: '${uvIndex.round()}',
        ),
      if (pollenMax != null)
        StatTileCard(
          label: s.weatherPollenLabel,
          value: _pollenLevelLabel(s, pollenMax),
        ),
      if (pm25 != null)
        StatTileCard(
          label: s.weatherAirLabel,
          value: '${pm25.round()} ${s.airQualityUnit}',
        ),
    ];

    final hasMetaRow =
        locality != null || weatherCode != null || updatedLabel != null;
    if (tiles.isEmpty && !hasMetaRow) return const SizedBox.shrink();

    final metaStyle = theme.textTheme.bodySmall?.copyWith(
      color: AppColors.textSecondary,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasMetaRow) ...[
            Row(
              children: [
                if (weatherCode != null) ...[
                  Icon(
                    weatherCodeIcon(weatherCode),
                    size: Sizes.p16,
                    color: AppColors.textSecondary,
                  ),
                  gapW8,
                ],
                if (locality != null)
                  Expanded(
                    child: Text(
                      locality,
                      style: metaStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                else
                  const Spacer(),
                if (updatedLabel != null) Text(updatedLabel, style: metaStyle),
              ],
            ),
            gapH8,
          ],
          for (var i = 0; i < tiles.length; i += 3) ...[
            if (i > 0) gapH8,
            Row(
              children: [
                for (var j = i; j < math.min(i + 3, tiles.length); j++) ...[
                  if (j > i) gapW8,
                  Expanded(child: tiles[j]),
                ],
                // Pad the last row so tiles keep the same width.
                for (var j = tiles.length; j < i + 3; j++) ...[
                  gapW8,
                  const Expanded(child: SizedBox.shrink()),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Freshness of the snapshot, only meaningful while looking at today.
  static String? _updatedLabel(AppStrings s, DateTime timestamp) {
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
