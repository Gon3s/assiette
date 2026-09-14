import 'package:assiette/features/environment_capture/background/environment_background_task.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/domain/device_location.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_repository.dart';
import 'package:assiette/features/environment_capture/domain/hourly_measure.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLocationReader implements LocationReader {
  _FakeLocationReader(this.position);

  final DeviceLocation? position;

  @override
  Future<bool> ensurePermission() async => position != null;

  @override
  Future<DeviceLocation?> readPosition() async => position;
}

class _FakeEnvironmentCaptureRepository
    implements EnvironmentCaptureRepository {
  _FakeEnvironmentCaptureRepository(this.result);

  final EnvironmentCaptureResult result;
  DeviceLocation? capturedLocation;

  @override
  Future<EnvironmentCaptureResult> captureSnapshot({
    DeviceLocation? location,
  }) async {
    capturedLocation = location;
    return result;
  }

  @override
  Future<int> backfillMissingDays({int days = 7}) =>
      throw UnsupportedError('Not used by this test');

  @override
  Future<List<HourlyMeasure>> pressureForecastSeries({
    required double latitude,
    required double longitude,
  }) => throw UnsupportedError('Not used by this test');
}

void main() {
  final position = DeviceLocation(
    latitude: 45.75,
    longitude: 4.85,
    timestamp: DateTime.utc(2026, 9, 14),
  );

  test('returns false without a position so WorkManager retries', () async {
    final repository = _FakeEnvironmentCaptureRepository(
      EnvironmentCaptureResult.captured,
    );

    final succeeded = await runEnvironmentCaptureCycle(
      locationReader: _FakeLocationReader(null),
      repository: repository,
      afterCapture: (_) async {},
    );

    expect(succeeded, isFalse);
    expect(repository.capturedLocation, isNull);
  });

  test('returns false when weather capture fails', () async {
    final repository = _FakeEnvironmentCaptureRepository(
      EnvironmentCaptureResult.failed,
    );

    final succeeded = await runEnvironmentCaptureCycle(
      locationReader: _FakeLocationReader(position),
      repository: repository,
      afterCapture: (_) async {},
    );

    expect(succeeded, isFalse);
    expect(repository.capturedLocation, position);
  });

  test('returns true after storing a snapshot', () async {
    final repository = _FakeEnvironmentCaptureRepository(
      EnvironmentCaptureResult.captured,
    );
    DeviceLocation? postCaptureLocation;

    final succeeded = await runEnvironmentCaptureCycle(
      locationReader: _FakeLocationReader(position),
      repository: repository,
      afterCapture: (location) async => postCaptureLocation = location,
    );

    expect(succeeded, isTrue);
    expect(postCaptureLocation, position);
  });

  test('treats a deduplicated capture as successful', () async {
    final repository = _FakeEnvironmentCaptureRepository(
      EnvironmentCaptureResult.skipped,
    );
    var postCaptureCalled = false;

    final succeeded = await runEnvironmentCaptureCycle(
      locationReader: _FakeLocationReader(position),
      repository: repository,
      afterCapture: (_) async => postCaptureCalled = true,
    );

    expect(succeeded, isTrue);
    expect(postCaptureCalled, isTrue);
  });

  test('returns false when post-capture work throws', () async {
    final repository = _FakeEnvironmentCaptureRepository(
      EnvironmentCaptureResult.captured,
    );

    final succeeded = await runEnvironmentCaptureCycle(
      locationReader: _FakeLocationReader(position),
      repository: repository,
      afterCapture: (_) async => throw Exception('notification failed'),
    );

    expect(succeeded, isFalse);
  });
}
