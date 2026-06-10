import 'package:assiette/utils/colored_debug_printer.dart';

/// Enum to define different environments
enum AppEnvironment {
  /// Development environment
  development,

  /// Production environment
  production,
}

/// Class to store the environment information
abstract class EnvInfo {
  /// The current environment
  static AppEnvironment environment = AppEnvironment.development;

  /// Check if we are in production environment
  static bool get isProduction => environment == AppEnvironment.production;

  /// Describe the environment in the console
  static void describe() {
    Print.white(
      'ENVIRONMENT',
      ' -------------------------------------------------------------------',
    );
    Print.yellow('ENVIRONMENT', ' | Environment : $environment');
    Print.white(
      'ENVIRONMENT',
      ' -------------------------------------------------------------------',
    );
  }
}
