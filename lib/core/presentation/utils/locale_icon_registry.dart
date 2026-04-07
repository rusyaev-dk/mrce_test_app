import 'package:mrce_test_app/gen/assets.gen.dart';

/// dart run build_runner build --delete-conflicting-outputs
class LocaleIconRegistry {
  static final Map<String, SvgGenImage> _localeIcons = <String, SvgGenImage>{
    'ru': Assets.icons.ru,
    'uz': Assets.icons.uz,
    'en': Assets.icons.gb,
  };

  static SvgGenImage iconFor(String locale) {
    final String code = locale.toLowerCase();
    return _localeIcons[code] ?? Assets.icons.gb;
  }
}
