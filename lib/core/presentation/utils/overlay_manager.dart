import 'package:flutter/material.dart';
import 'package:mrce_test_app/app/app.dart';

/// A utility class for managing reusable overlay widgets in the application.
///
/// Provides methods to create and insert custom overlay entries
/// that can appear above the main widget tree, such as keyboard toolbars
/// or action buttons.
final class OverlayManager {
  /// The height of the accessory bar displayed above the keyboard.
  static const double _kAccessoryHeight = 48;

  /// Creates an overlay entry that displays a confirmation button
  /// right above the on-screen keyboard.
  ///
  /// This is useful for input fields where the user should explicitly
  /// confirm their action before closing the keyboard, such as entering
  /// numeric or sensitive data.
  ///
  /// The overlay automatically positions itself above the keyboard
  /// using the current [MediaQuery.viewInsets.bottom] value.
  ///
  /// Example:
  /// ```dart
  /// final entry = OverlayManager.keyboardConfirmOverlay(
  ///   context,
  ///   onConfirm: () => print('Confirmed!'),
  /// );
  /// Overlay.of(context).insert(entry);
  /// ```
  ///
  /// Parameters:
  /// - [context]: The current [BuildContext], used to resolve theme
  ///   colors, text styles, and localization strings.
  /// - [onConfirm]: A callback invoked when the confirmation button is pressed.
  ///
  /// Returns:
  /// An [OverlayEntry] that can be inserted into the app's overlay stack.
  static OverlayEntry keyboardConfirmOverlay(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    final colorScheme = context.colorScheme;
    final textScheme = context.textScheme;

    return OverlayEntry(
      builder: (ctx) {
        final double bottomInset = MediaQuery.of(ctx).viewInsets.bottom;

        return Positioned(
          left: 0,
          right: 0,
          bottom: bottomInset,
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              top: false,
              bottom: false,
              child: Container(
                height: _kAccessoryHeight,
                padding: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outlineVariant,
                      width: 0.8,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onConfirm,
                    child: Text(
                      "Ок",
                      style: textScheme.label.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
