@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/onboarding/data/onboarding_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftOnboardingRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftOnboardingRepository(db: db);
  });

  tearDown(() => db.close());

  group('watchOnboardingDone', () {
    test('defaults to false when nothing was ever completed', () async {
      expect(await repository.watchOnboardingDone().first, isFalse);
    });

    test('emits true after completeOnboarding', () async {
      await repository.completeOnboarding();

      expect(await repository.watchOnboardingDone().first, isTrue);
    });

    test('re-emits when completeOnboarding is called', () async {
      final emissions = <bool>[];
      final sub = repository.watchOnboardingDone().listen(emissions.add);
      addTearDown(sub.cancel);
      await pumpEventQueue();

      await repository.completeOnboarding();
      await pumpEventQueue();

      expect(emissions.first, isFalse);
      expect(emissions.last, isTrue);
    });
  });
}
