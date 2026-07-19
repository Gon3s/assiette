import 'package:flutter/material.dart';

/// Maps a WMO weather interpretation code (Open-Meteo `weather_code`) to a
/// Material icon.
///
/// Code groups, per the Open-Meteo documentation: 0 clear, 1-3 clouds,
/// 45/48 fog, 51-57 drizzle, 61-67 rain, 71-77 snow, 80-82 rain showers,
/// 85/86 snow showers, 95-99 thunderstorm.
IconData weatherCodeIcon(int code) => switch (code) {
      0 => Icons.wb_sunny_outlined,
      1 || 2 => Icons.wb_cloudy_outlined,
      3 => Icons.cloud_outlined,
      45 || 48 => Icons.foggy,
      >= 51 && <= 57 => Icons.grain,
      >= 61 && <= 67 || >= 80 && <= 82 => Icons.umbrella_outlined,
      >= 71 && <= 77 || 85 || 86 => Icons.ac_unit,
      >= 95 => Icons.thunderstorm_outlined,
      _ => Icons.cloud_outlined,
    };
