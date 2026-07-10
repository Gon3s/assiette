import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';

/// App info screen: version, privacy stance, and third-party attributions.
class SettingsScreen extends StatelessWidget {
  /// Creates a [SettingsScreen].
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(s.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.p16),
        children: [
          Text(s.aboutSectionTitle, style: theme.textTheme.titleMedium),
          gapH8,
          Text(s.openMeteoAttribution, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
