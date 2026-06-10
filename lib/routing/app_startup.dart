import 'dart:async';

import 'package:assiette/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup.freezed.dart';
part 'app_startup.g.dart';

/// The application startup provider.
@Riverpod(keepAlive: true)
Future<AppDependencies> appStartup(Ref ref) async {
  return const AppDependencies();
}

/// Represents the dependencies required by the app.
@freezed
abstract class AppDependencies with _$AppDependencies {
  /// Creates a new instance of the [AppDependencies] class.
  const factory AppDependencies() = _AppDependencies;
}

/// Widget class to manage asynchronous initialization of the application.
class AppStartupWidget extends ConsumerWidget {
  /// Creates a new instance of the [AppStartupWidget] widget.
  const AppStartupWidget({required this.onLoaded, super.key});

  /// The widget builder to use when the application has loaded.
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      data: (_) => onLoaded(context),
      loading: () => const AppStartupLoadingWidget(),
      error: (e, st) => AppStartupErrorWidget(
        message: e.toString(),
        onRetry: () => ref.refresh(appStartupProvider),
      ),
    );
  }
}

/// Loading widget shown during startup.
class AppStartupLoadingWidget extends StatelessWidget {
  /// Creates a new instance of the [AppStartupLoadingWidget] widget.
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

/// Error widget shown when startup fails.
class AppStartupErrorWidget extends StatelessWidget {
  /// Creates a new instance of the [AppStartupErrorWidget] widget.
  const AppStartupErrorWidget({
    required this.message,
    required this.onRetry,
    super.key,
  });

  /// The error message to display.
  final String message;

  /// The callback to invoke when the user wants to retry.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: Theme.of(context).textTheme.headlineSmall),
            gapH16,
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
