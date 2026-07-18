import 'package:assiette/common_widgets/stat_tile_card.dart';
import 'package:assiette/constants/app_colors.dart';
import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Header of the day view: latest weather/pressure captured for the
/// day, shown as two stat tiles (mockup-style data grid).
class DayHeader extends ConsumerWidget {
  /// Creates a [DayHeader].
  const DayHeader({super.key});

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

    final temperature = weather.temperature;
    final pressure = weather.pressure;
    final delta = weather.pressureDelta;

    final tiles = <Widget>[
      if (temperature != null)
        Expanded(
          child: StatTileCard(
            label: s.weatherTemperatureLabel,
            value: '${temperature.round()}°C',
            accent: AppColors.turquoise,
          ),
        ),
      if (pressure != null)
        Expanded(
          child: StatTileCard(
            label: s.weatherPressureLabel,
            value: '${pressure.round()} ${s.pressureUnit}',
            trailing: delta == null || delta == 0
                ? null
                : Icon(
                    delta > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                    size: Sizes.p16,
                    color: delta > 0
                        ? AppColors.turquoise
                        : AppColors.alert,
                  ),
          ),
        ),
    ];
    if (tiles.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p8,
      ),
      child: Row(
        children: [
          for (final (i, tile) in tiles.indexed) ...[
            if (i > 0) gapW8,
            tile,
          ],
        ],
      ),
    );
  }
}
