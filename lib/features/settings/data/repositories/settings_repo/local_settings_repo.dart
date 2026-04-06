import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/settings/data/data.dart';

class LocalSettingsRepo implements ISettingsRepo {
  LocalSettingsRepo({required IKeyValueStorage storage}) : _storage = storage;

  final IKeyValueStorage _storage;
  final String _languageCodeKey = "language_code";
  final String _themeKey = "theme";

  @override
  Future<bool> changeLanguageCode({required String newLanguageCode}) async {
    return await _storage.write<String>(
      key: _languageCodeKey,
      value: newLanguageCode,
    );
  }

  @override
  Future<String> getCurrentLanguageCode() async {
    return await _storage.read<String>(key: _languageCodeKey) ??
        AppConfig.defaultLanguageCode;
  }

  @override
  Future<bool> changeThemeMode({required String newThemeCode}) async {
    return await _storage.write<String>(key: _themeKey, value: newThemeCode);
  }

  @override
  Future<String> getCurrentThemeMode() async {
    return await _storage.read<String>(key: _themeKey) ??
        AppConfig.defaultThemeMode;
  }
}
