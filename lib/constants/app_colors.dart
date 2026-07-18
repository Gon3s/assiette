import 'package:flutter/material.dart';

/// Palette of the app, taken from the reference style guide (Rubik +
/// 5 colors) and its dark mobile mockups.
///
/// Widgets should not hardcode colors: use the [ColorScheme] exposed by
/// the theme, or these constants when a semantic accent is needed
/// (e.g. symptom categories).
abstract final class AppColors {
  /// Deep navy used as scaffold background (`#161D34`).
  static const background = Color(0xFF161D34);

  /// Card surface, slightly lighter than [background].
  static const surface = Color(0xFF1E2745);

  /// Elevated surface (inputs, chips, sheets).
  static const surfaceAlt = Color(0xFF273153);

  /// Muted slate (`#475575`): borders and dividers only — too low
  /// contrast on [background] for essential text.
  static const slate = Color(0xFF475575);

  /// Primary blue (`#3E64FF`): CTAs, active elements.
  static const primary = Color(0xFF3E64FF);

  /// Turquoise accent (`#36F0D8`): positive signals, progress.
  static const turquoise = Color(0xFF36F0D8);

  /// Red/pink accent (`#F6485C`): errors and negative signals.
  static const alert = Color(0xFFF6485C);

  /// Warm yellow accent used for intermediate signals, mirroring the
  /// mockups' yellow data dots.
  static const warning = Color(0xFFFFC93C);

  /// Near-white main text color.
  static const textPrimary = Color(0xFFF4F6FF);

  /// Secondary text: lightened slate that keeps AA contrast on
  /// [background].
  static const textSecondary = Color(0xFF93A0C4);
}
