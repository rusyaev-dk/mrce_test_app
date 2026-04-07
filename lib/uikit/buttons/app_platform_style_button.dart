import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppPlatformButtonVariant {
  /// Cupertino: plain [CupertinoButton]. Material: [OutlinedButton.icon].
  secondary,

  /// Cupertino: [CupertinoButton.filled]. Material: [FilledButton.icon].
  primary,
}

/// Action button that follows Cupertino vs Material control styles for the
/// same semantics (used e.g. in map geocode actions).
class AppPlatformStyleButton extends StatelessWidget {
  const AppPlatformStyleButton({
    required this.label,
    required this.onPressed,
    required this.isCupertino,
    required this.variant,
    this.icon,
    this.cupertinoVerticalPadding = 8,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isCupertino;
  final AppPlatformButtonVariant variant;
  final IconData? icon;
  final double cupertinoVerticalPadding;

  static const double _materialIconSize = 18;

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(vertical: cupertinoVerticalPadding);

    if (isCupertino) {
      return switch (variant) {
        AppPlatformButtonVariant.secondary => CupertinoButton(
            padding: padding,
            onPressed: onPressed,
            child: Text(label),
          ),
        AppPlatformButtonVariant.primary => CupertinoButton.filled(
            padding: padding,
            onPressed: onPressed,
            child: Text(label),
          ),
      };
    }

    return switch (variant) {
      AppPlatformButtonVariant.secondary => icon != null
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: _materialIconSize),
              label: Text(label),
            )
          : OutlinedButton(
              onPressed: onPressed,
              child: Text(label),
            ),
      AppPlatformButtonVariant.primary => icon != null
          ? FilledButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: _materialIconSize),
              label: Text(label),
            )
          : FilledButton(
              onPressed: onPressed,
              child: Text(label),
            ),
    };
  }
}
