// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Draft state and persistence for the notification settings screen
/// (US-16): edits are local until [save] persists them and reschedules the
/// corresponding notifications.

@ProviderFor(NotificationSettingsController)
final notificationSettingsControllerProvider =
    NotificationSettingsControllerProvider._();

/// Draft state and persistence for the notification settings screen
/// (US-16): edits are local until [save] persists them and reschedules the
/// corresponding notifications.
final class NotificationSettingsControllerProvider
    extends
        $AsyncNotifierProvider<
          NotificationSettingsController,
          NotificationPreferences
        > {
  /// Draft state and persistence for the notification settings screen
  /// (US-16): edits are local until [save] persists them and reschedules the
  /// corresponding notifications.
  NotificationSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSettingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSettingsControllerHash();

  @$internal
  @override
  NotificationSettingsController create() => NotificationSettingsController();
}

String _$notificationSettingsControllerHash() =>
    r'01f935d0f2965c12388b455689578e2fa81dd878';

/// Draft state and persistence for the notification settings screen
/// (US-16): edits are local until [save] persists them and reschedules the
/// corresponding notifications.

abstract class _$NotificationSettingsController
    extends $AsyncNotifier<NotificationPreferences> {
  FutureOr<NotificationPreferences> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<NotificationPreferences>,
              NotificationPreferences
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NotificationPreferences>,
                NotificationPreferences
              >,
              AsyncValue<NotificationPreferences>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
