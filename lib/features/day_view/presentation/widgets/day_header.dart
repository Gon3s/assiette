import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Header of the day view: latest weather/pressure captured for the day.
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

    final parts = <Widget>[
      const Icon(Icons.thermostat, size: Sizes.p16),
    ];
    if (weather.temperature != null) {
      parts.add(Text('${weather.temperature!.round()}°C'));
    }
    if (weather.pressure != null) {
      parts
        ..add(gapW16)
        ..add(const Icon(Icons.speed, size: Sizes.p16))
        ..add(gapW4)
        ..add(Text('${weather.pressure!.round()} ${s.pressureUnit}'));
      final delta = weather.pressureDelta;
      if (delta != null && delta != 0) {
        parts
          ..add(gapW4)
          ..add(
            Icon(
              delta > 0 ? Icons.arrow_upward : Icons.arrow_downward,
              size: Sizes.p16,
              color: delta > 0 ? Colors.green : Colors.deepOrange,
            ),
          );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p8,
      ),
      child: Row(children: parts),
    );
  }
}
