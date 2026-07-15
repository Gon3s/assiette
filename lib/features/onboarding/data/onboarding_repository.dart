import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/onboarding/domain/onboarding_repository.dart';

/// Drift-backed implementation of [OnboardingRepository].
class DriftOnboardingRepository implements OnboardingRepository {
  /// Creates a [DriftOnboardingRepository].
  DriftOnboardingRepository({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  @override
  Stream<bool> watchOnboardingDone() => _db.appSettingsDao.watchOnboardingDone();

  @override
  Future<void> completeOnboarding() =>
      _db.appSettingsDao.setOnboardingDone(done: true);
}
