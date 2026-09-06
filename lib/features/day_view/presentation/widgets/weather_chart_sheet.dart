import 'dart:math' as math;

import 'package:assiette/constants/app_colors.dart';
import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Which measure the weather chart sheet plots.
enum WeatherChartKind {
  /// Day evolution of the temperature (°C).
  temperature,

  /// Day evolution of the sea-level pressure (hPa), with the forecast for
  /// the rest of the day when viewing today.
  pressure,
}

/// Opens the bottom sheet charting the selected day's [kind] evolution.
Future<void> showWeatherChartSheet(
  BuildContext context,
  WeatherChartKind kind,
  DateTime date,
) => showModalBottomSheet<void>(
  context: context,
  builder: (context) => WeatherChartSheet(kind: kind, date: date),
);

/// Bottom sheet plotting the measured evolution of one weather measure
/// over the selected day.
class WeatherChartSheet extends ConsumerWidget {
  /// Creates a [WeatherChartSheet].
  const WeatherChartSheet({required this.kind, required this.date, super.key});

  /// The measure to plot.
  final WeatherChartKind kind;

  /// Day whose measured series is displayed.
  final DateTime date;

  bool get _isTemperature => kind == WeatherChartKind.temperature;

  Color get _lineColor =>
      _isTemperature ? AppColors.turquoise : AppColors.primary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final theme = Theme.of(context);
    final series = ref.watch(dayWeatherSeriesProvider(date)).value ?? const [];

    final points = <({double hour, double value})>[];
    for (final point in series) {
      final value = _isTemperature ? point.temperature : point.pressure;
      if (value == null) continue;
      final local = point.timestamp.toLocal();
      points.add((hour: local.hour + local.minute / 60, value: value));
    }

    // Pressure forecast for the hours still ahead, only when viewing today.
    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    var forecastPoints = const <({double hour, double value})>[];
    if (!_isTemperature && isToday) {
      final forecast =
          ref.watch(dayPressureForecastProvider(date)).value ?? const [];
      final lastMeasuredHour = points.isEmpty ? 0.0 : points.last.hour;
      forecastPoints = [
        for (final measure in forecast)
          if (measure.time.year == date.year &&
              measure.time.month == date.month &&
              measure.time.day == date.day &&
              measure.time.hour + measure.time.minute / 60 >= lastMeasuredHour)
            (
              hour: measure.time.hour + measure.time.minute / 60,
              value: measure.value,
            ),
      ];
    }

    final title = _isTemperature
        ? s.weatherTemperatureLabel
        : s.weatherPressureLabel;
    final unit = _isTemperature ? '°C' : s.pressureUnit;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Sizes.p16,
          Sizes.p16,
          Sizes.p16,
          Sizes.p24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (forecastPoints.isNotEmpty) ...[
              gapH8,
              _ChartLegend(
                lineColor: _lineColor,
                measuredLabel: s.weatherChartMeasuredLegend,
                forecastLabel: s.weatherChartForecastLegend,
              ),
            ],
            gapH16,
            SizedBox(
              height: 220,
              child: points.length < 2 && forecastPoints.length < 2
                  ? Center(
                      child: Text(
                        s.weatherChartNoData,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : _WeatherLineChart(
                      points: points,
                      forecastPoints: forecastPoints,
                      lineColor: _lineColor,
                      unit: unit,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  const _ChartLegend({
    required this.lineColor,
    required this.measuredLabel,
    required this.forecastLabel,
  });

  final Color lineColor;
  final String measuredLabel;
  final String forecastLabel;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: AppColors.textSecondary,
    );
    return Row(
      children: [
        _legendLine(lineColor, dashed: false),
        gapW4,
        Text(measuredLabel, style: labelStyle),
        gapW16,
        _legendLine(lineColor.withValues(alpha: 0.55), dashed: true),
        gapW4,
        Text(forecastLabel, style: labelStyle),
      ],
    );
  }

  Widget _legendLine(Color color, {required bool dashed}) => SizedBox(
    width: Sizes.p20,
    height: 2,
    child: dashed
        ? Row(
            children: [
              for (var i = 0; i < 3; i++) ...[
                Expanded(child: ColoredBox(color: color)),
                if (i < 2) const SizedBox(width: 3),
              ],
            ],
          )
        : ColoredBox(color: color),
  );
}

class _WeatherLineChart extends StatelessWidget {
  const _WeatherLineChart({
    required this.points,
    required this.forecastPoints,
    required this.lineColor,
    required this.unit,
  });

  final List<({double hour, double value})> points;
  final List<({double hour, double value})> forecastPoints;
  final Color lineColor;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final values = [
      for (final p in points) p.value,
      for (final p in forecastPoints) p.value,
    ];
    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);
    // Flat series still need a visible band around the line.
    final padding = math.max((maxValue - minValue) * 0.15, 1);
    final minY = (minValue - padding).floorToDouble();
    final maxY = (maxValue + padding).ceilToDouble();

    final labelStyle = theme.textTheme.bodySmall?.copyWith(
      color: AppColors.textSecondary,
    );

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 24,
        minY: minY,
        maxY: maxY,
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: math.max(((maxY - minY) / 4).roundToDouble(), 1),
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.slate.withValues(alpha: 0.3),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 6,
              reservedSize: 28,
              getTitlesWidget: (value, meta) => SideTitleWidget(
                meta: meta,
                child: Text('${value.toInt()}h', style: labelStyle),
              ),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: math.max(((maxY - minY) / 4).roundToDouble(), 1),
              reservedSize: 40,
              getTitlesWidget: (value, meta) => SideTitleWidget(
                meta: meta,
                child: Text('${value.toInt()}', style: labelStyle),
              ),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => AppColors.surfaceAlt,
            getTooltipItems: (spots) => [
              for (final spot in spots)
                LineTooltipItem(
                  '${spot.x.toInt()}h · '
                  '${spot.y.toStringAsFixed(1)} $unit',
                  theme.textTheme.bodySmall!.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
            ],
          ),
        ),
        lineBarsData: [
          if (points.isNotEmpty)
            LineChartBarData(
              spots: [for (final p in points) FlSpot(p.hour, p.value)],
              color: lineColor,
              isCurved: true,
              preventCurveOverShooting: true,
              dotData: FlDotData(show: points.length <= 12),
            ),
          if (forecastPoints.isNotEmpty)
            LineChartBarData(
              spots: [
                for (final p in forecastPoints) FlSpot(p.hour, p.value),
              ],
              color: lineColor.withValues(alpha: 0.55),
              isCurved: true,
              preventCurveOverShooting: true,
              dashArray: [6, 4],
              dotData: const FlDotData(show: false),
            ),
        ],
      ),
    );
  }
}
