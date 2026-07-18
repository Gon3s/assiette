// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_export_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Generates the journal PDF for a chosen date range (US-17). Idle until
/// [generate] is called.

@ProviderFor(PdfExportController)
final pdfExportControllerProvider = PdfExportControllerProvider._();

/// Generates the journal PDF for a chosen date range (US-17). Idle until
/// [generate] is called.
final class PdfExportControllerProvider
    extends $AsyncNotifierProvider<PdfExportController, Uint8List?> {
  /// Generates the journal PDF for a chosen date range (US-17). Idle until
  /// [generate] is called.
  PdfExportControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pdfExportControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pdfExportControllerHash();

  @$internal
  @override
  PdfExportController create() => PdfExportController();
}

String _$pdfExportControllerHash() =>
    r'04f5d3d547dac2157618730fc3fa1f7b7899e2b1';

/// Generates the journal PDF for a chosen date range (US-17). Idle until
/// [generate] is called.

abstract class _$PdfExportController extends $AsyncNotifier<Uint8List?> {
  FutureOr<Uint8List?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Uint8List?>, Uint8List?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Uint8List?>, Uint8List?>,
              AsyncValue<Uint8List?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
