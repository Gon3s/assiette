import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/constants/app_theme.dart';
import 'package:flutter/material.dart';

/// Small stat tile mirroring the reference mockups' data grid: muted
/// label on top, prominent value below, optional accent dot or custom
/// trailing widget.
class StatTileCard extends StatelessWidget {
  /// Creates a [StatTileCard].
  const StatTileCard({
    required this.label,
    required this.value,
    this.accent,
    this.trailing,
    this.onTap,
    super.key,
  });

  /// Short label describing the stat.
  final String label;

  /// The stat value, displayed prominently.
  final String value;

  /// Optional color of the small accent dot next to the value.
  final Color? accent;

  /// Optional widget displayed after the value (e.g. a trend arrow);
  /// takes precedence over [accent].
  final Widget? trailing;

  /// Optional tap handler; when set, the whole tile is tappable.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p16,
            vertical: Sizes.p12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              gapH4,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (trailing != null)
                    trailing!
                  else if (accent != null)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                      ),
                      child: const SizedBox.square(dimension: Sizes.p8),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
