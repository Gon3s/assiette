// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [NotificationsService] implementation. Overridden with a
/// fake in tests that exercise callers of this provider (e.g. the
/// notification settings controller), since the real one needs a platform
/// channel that isn't registered in unit tests.

@ProviderFor(notificationsService)
final notificationsServiceProvider = NotificationsServiceProvider._();

/// Provides the [NotificationsService] implementation. Overridden with a
/// fake in tests that exercise callers of this provider (e.g. the
/// notification settings controller), since the real one needs a platform
/// channel that isn't registered in unit tests.

final class NotificationsServiceProvider
    extends
        $FunctionalProvider<
          NotificationsService,
          NotificationsService,
          NotificationsService
        >
    with $Provider<NotificationsService> {
  /// Provides the [NotificationsService] implementation. Overridden with a
  /// fake in tests that exercise callers of this provider (e.g. the
  /// notification settings controller), since the real one needs a platform
  /// channel that isn't registered in unit tests.
  NotificationsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsServiceHash();

  @$internal
  @override
  $ProviderElement<NotificationsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationsService create(Ref ref) {
    return notificationsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsService>(value),
    );
  }
}

String _$notificationsServiceHash() =>
    r'34ea7b5a2a02749611b452a165c6722c99543738';
