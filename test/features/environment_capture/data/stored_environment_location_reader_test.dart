import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/environment_capture/data/stored_environment_location_reader.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late bool consent;
  late StoredEnvironmentLocationReader reader;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    consent = true;
    reader = StoredEnvironmentLocationReader(
      environmentDao: db.environmentDao,
      canUseLocation: () async => consent,
    );
  });
  tearDown(() => db.close());

  Future<void> seed({double? latitude = 45.75}) =>
      db.environmentDao.insertSnapshot(
        EnvironmentSnapshotsCompanion.insert(
          id: 'place',
          timestamp: DateTime.utc(2026),
          lat: Value(latitude),
          lon: const Value(4.85),
        ),
      );

  test(
    'uses the recorded place instead of asking Android for a position',
    () async {
      await seed();
      final position = await reader.readPosition();
      expect(position?.latitude, 45.75);
      expect(position?.longitude, 4.85);
      expect(position?.timestamp.toUtc(), DateTime.utc(2026));
    },
  );

  test('does nothing until a foreground position has been recorded', () async {
    expect(await reader.readPosition(), isNull);
  });

  test('does not use a stored place after consent is revoked', () async {
    await seed();
    consent = false;
    expect(await reader.ensurePermission(), isFalse);
    expect(await reader.readPosition(), isNull);
  });

  test('does not synthesize a position from incomplete coordinates', () async {
    await seed(latitude: null);
    expect(await reader.readPosition(), isNull);
  });
}
