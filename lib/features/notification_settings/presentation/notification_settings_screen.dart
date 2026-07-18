import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/notification_settings/presentation/notification_settings_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notification settings screen (US-16): per-channel toggles and reminder
/// times, persisted and rescheduled on save.
class NotificationSettingsScreen extends ConsumerWidget {
  /// Creates a [NotificationSettingsScreen].
  const NotificationSettingsScreen({super.key});

  Future<void> _pickTime(
    BuildContext context, {
    required int hour,
    required int minute,
    required void Function(int hour, int minute) onPicked,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
    );
    if (picked == null) return;
    onPicked(picked.hour, picked.minute);
  }

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final s = AppStrings.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final saved = await ref
        .read(notificationSettingsControllerProvider.notifier)
        .save(s);
    if (!context.mounted) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(saved ? s.notificationSettingsSaved : s.errorGeneric),
        ),
      );
  }

  String _formatTime(int hour, int minute) =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  Widget _timeTile(
    BuildContext context,
    WidgetRef ref, {
    required String label,
    required int hour,
    required int minute,
    required void Function(int hour, int minute) onPicked,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const SizedBox(width: Sizes.p24),
      title: Text(label),
      trailing: Text(_formatTime(hour, minute)),
      onTap: () => _pickTime(context, hour: hour, minute: minute, onPicked: onPicked),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final prefsAsync = ref.watch(notificationSettingsControllerProvider);
    final notifier = ref.read(notificationSettingsControllerProvider.notifier);
    final isSaving = prefsAsync.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(s.notificationSettingsTitle)),
      body: prefsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(s.errorGeneric)),
        data: (prefs) => ListView(
          padding: const EdgeInsets.all(Sizes.p16),
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(s.notificationChannelMealsName),
              subtitle: Text(s.notificationChannelMealsDescription),
              value: prefs.mealsEnabled,
              onChanged: (enabled) =>
                  notifier.setMealsEnabled(enabled: enabled),
            ),
            if (prefs.mealsEnabled) ...[
              _timeTile(
                context,
                ref,
                label: s.mealTypeBreakfast,
                hour: prefs.breakfastHour,
                minute: prefs.breakfastMinute,
                onPicked: (hour, minute) =>
                    notifier.setBreakfastTime(hour: hour, minute: minute),
              ),
              _timeTile(
                context,
                ref,
                label: s.mealTypeLunch,
                hour: prefs.lunchHour,
                minute: prefs.lunchMinute,
                onPicked: (hour, minute) =>
                    notifier.setLunchTime(hour: hour, minute: minute),
              ),
              _timeTile(
                context,
                ref,
                label: s.mealTypeDinner,
                hour: prefs.dinnerHour,
                minute: prefs.dinnerMinute,
                onPicked: (hour, minute) =>
                    notifier.setDinnerTime(hour: hour, minute: minute),
              ),
            ],
            gapH8,
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(s.notificationChannelSleepName),
              subtitle: Text(s.notificationChannelSleepDescription),
              value: prefs.sleepEnabled,
              onChanged: (enabled) =>
                  notifier.setSleepEnabled(enabled: enabled),
            ),
            if (prefs.sleepEnabled)
              _timeTile(
                context,
                ref,
                label: s.sleepCardTitle,
                hour: prefs.sleepHour,
                minute: prefs.sleepMinute,
                onPicked: (hour, minute) =>
                    notifier.setSleepTime(hour: hour, minute: minute),
              ),
            gapH8,
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(s.notificationChannelWeatherName),
              subtitle: Text(s.notificationChannelWeatherDescription),
              value: prefs.weatherEnabled,
              onChanged: (enabled) =>
                  notifier.setWeatherEnabled(enabled: enabled),
            ),
            gapH8,
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(s.notificationChannelSymptomsName),
              subtitle: Text(s.notificationChannelSymptomsDescription),
              value: prefs.symptomsEnabled,
              onChanged: (enabled) =>
                  notifier.setSymptomsEnabled(enabled: enabled),
            ),
            if (prefs.symptomsEnabled)
              _timeTile(
                context,
                ref,
                label: s.notificationChannelSymptomsName,
                hour: prefs.symptomsHour,
                minute: prefs.symptomsMinute,
                onPicked: (hour, minute) =>
                    notifier.setSymptomsTime(hour: hour, minute: minute),
              ),
            gapH24,
            FilledButton(
              onPressed: isSaving ? null : () => _save(context, ref),
              child: isSaving
                  ? const SizedBox(
                      height: Sizes.p20,
                      width: Sizes.p20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(s.save),
            ),
          ],
        ),
      ),
    );
  }
}
