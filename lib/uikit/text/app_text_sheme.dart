import 'package:flutter/material.dart';
import 'package:mrce_test_app/uikit/uikit.dart';

class AppTextScheme extends ThemeExtension<AppTextScheme> {
  AppTextScheme.base()
    : display = AppTextStyle.displaySmall.value,
      headline = AppTextStyle.headlineSmall.value,
      label = AppTextStyle.labelMedium.value,
      titleSmall = AppTextStyle.titleSmall.value,
      titleMedium = AppTextStyle.titleMedium.value,
      bodySmall = AppTextStyle.bodySmall.value,
      bodyMedium = AppTextStyle.bodyMedium.value,
      bodyLarge = AppTextStyle.bodyLarge.value;

  const AppTextScheme._({
    required this.display,
    required this.headline,
    required this.label,
    required this.titleSmall,
    required this.titleMedium,
    required this.bodySmall,
    required this.bodyMedium,
    required this.bodyLarge,
  });
  final TextStyle display;
  final TextStyle headline;
  final TextStyle label;
  final TextStyle titleSmall;
  final TextStyle titleMedium;
  final TextStyle bodySmall;
  final TextStyle bodyMedium;
  final TextStyle bodyLarge;

  @override
  ThemeExtension<AppTextScheme> lerp(
    ThemeExtension<AppTextScheme>? other,
    double t,
  ) {
    if (other is! AppTextScheme) {
      return this;
    }

    return AppTextScheme._(
      display: TextStyle.lerp(display, other.display, t)!,
      headline: TextStyle.lerp(headline, other.headline, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
    );
  }

  @override
  AppTextScheme copyWith({
    TextStyle? display,
    TextStyle? headline,
    TextStyle? label,
    TextStyle? titleSmall,
    TextStyle? titleMedium,
    TextStyle? bodySmall,
    TextStyle? bodyMedium,
    TextStyle? bodyLarge,
  }) {
    return AppTextScheme._(
      display: display ?? this.display,
      headline: headline ?? this.headline,
      label: label ?? this.label,
      titleSmall: titleSmall ?? this.titleSmall,
      titleMedium: titleMedium ?? this.titleMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodyLarge: bodyLarge ?? this.bodyLarge,
    );
  }

  static AppTextScheme of(BuildContext context) {
    return Theme.of(context).extension<AppTextScheme>() ??
        _throwThemeExceptionFromFunc(context);
  }
}

Never _throwThemeExceptionFromFunc(BuildContext context) =>
    throw Exception('$AppTextScheme not found in $context');
