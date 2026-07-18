// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_export_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [JournalExportRepository] implementation.

@ProviderFor(journalExportRepository)
final journalExportRepositoryProvider = JournalExportRepositoryProvider._();

/// Provides the [JournalExportRepository] implementation.

final class JournalExportRepositoryProvider
    extends
        $FunctionalProvider<
          JournalExportRepository,
          JournalExportRepository,
          JournalExportRepository
        >
    with $Provider<JournalExportRepository> {
  /// Provides the [JournalExportRepository] implementation.
  JournalExportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalExportRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalExportRepositoryHash();

  @$internal
  @override
  $ProviderElement<JournalExportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JournalExportRepository create(Ref ref) {
    return journalExportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JournalExportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JournalExportRepository>(value),
    );
  }
}

String _$journalExportRepositoryHash() =>
    r'757ebb7fcf02493ba520c3345fe9fe8aee89046f';
