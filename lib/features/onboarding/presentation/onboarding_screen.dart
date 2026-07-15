import 'dart:async';
import 'dart:io';

import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/environment_capture/background/environment_background_task.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/onboarding/domain/onboarding_repository.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// First-launch onboarding: value proposition, then a screen that
/// contextually explains and requests location permission (used to
/// auto-capture weather/pressure). Skippable; never shown again once
/// completed.
class OnboardingScreen extends ConsumerStatefulWidget {
  /// Creates an [OnboardingScreen].
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    unawaited(
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _finish({required bool requestLocation}) async {
    if (requestLocation && Platform.isAndroid) {
      try {
        final hasPermission =
            await GeolocatorLocationReader().ensurePermission();
        if (hasPermission) {
          await registerEnvironmentCaptureTask();
          await registerImmediateEnvironmentCaptureTask();
        }
      } on Exception {
        // Best-effort: onboarding must complete regardless.
      }
    }
    await ref.read(onboardingRepositoryProvider).completeOnboarding();
    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final pages = [
      _OnboardingPage(
        icon: Icons.restaurant,
        title: s.onboardingValueTitle,
        body: s.onboardingValueBody,
      ),
      _OnboardingPage(
        icon: Icons.photo_camera,
        title: s.onboardingLoggingTitle,
        body: s.onboardingLoggingBody,
      ),
      _OnboardingPage(
        icon: Icons.cloud,
        title: s.onboardingWeatherTitle,
        body: s.onboardingWeatherBody,
      ),
      _OnboardingPage(
        icon: Icons.location_on,
        title: s.onboardingPermissionTitle,
        body: s.onboardingPermissionBody,
      ),
    ];
    final isLastPage = _page == pages.length - 1;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Sizes.p48,
              child: isLastPage
                  ? null
                  : Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => _finish(requestLocation: false),
                        child: Text(s.onboardingSkip),
                      ),
                    ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _page = page),
                children: pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < pages.length; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: Sizes.p4,
                      vertical: Sizes.p16,
                    ),
                    width: Sizes.p8,
                    height: Sizes.p8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == _page
                          ? theme.colorScheme.primary
                          : theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Sizes.p16,
                0,
                Sizes.p16,
                Sizes.p24,
              ),
              child: isLastPage
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilledButton(
                          onPressed: () => _finish(requestLocation: true),
                          child: Text(s.onboardingEnableLocation),
                        ),
                        gapH8,
                        TextButton(
                          onPressed: () => _finish(requestLocation: false),
                          child: Text(s.onboardingMaybeLater),
                        ),
                      ],
                    )
                  : FilledButton(
                      onPressed: _nextPage,
                      child: Text(s.onboardingNext),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: Sizes.p64, color: Theme.of(context).colorScheme.primary),
          gapH24,
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          gapH16,
          Text(
            body,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
