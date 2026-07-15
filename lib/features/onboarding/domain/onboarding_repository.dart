import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/onboarding/data/onboarding_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_repository.g.dart';

/// Persistence for the one-time onboarding flag.
abstract class OnboardingRepository {
  /// Watches whether the onboarding has already been completed.
  Stream<bool> watchOnboardingDone();

  /// Marks the onboarding as completed, so it never shows again.
  Future<void> completeOnboarding();
}

/// Provides the [OnboardingRepository] implementation.
@riverpod
OnboardingRepository onboardingRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftOnboardingRepository(db: db);
}

/// Whether the onboarding has already been completed, gating the router.
@riverpod
Stream<bool> onboardingDone(Ref ref) =>
    ref.watch(onboardingRepositoryProvider).watchOnboardingDone();
