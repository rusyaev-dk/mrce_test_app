import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/core.dart';
import 'package:flutter_app_template/features/settings/data/data.dart';

class LocalSettingsRepo implements ISettingsRepo {
  LocalSettingsRepo({required IKeyValueStorage storage}) : _storage = storage;

  final IKeyValueStorage _storage;
  final String _languageCodeKey = "languageCode";
  final String _themeKey = "theme";

  @override
  Future<bool> changeLanguageCode({required String newLanguageCode}) async {
    return await _storage.save(key: _languageCodeKey, value: newLanguageCode);
  }

  @override
  Future<String> getCurrentLanguageCode() async {
    return await _storage.get(key: _languageCodeKey) ??
        AppConfig.defaultLanguageCode;
  }

  @override
  Future<bool> changeThemeMode({required String newThemeCode}) async {
    return await _storage.save(key: _themeKey, value: newThemeCode);
  }

  @override
  Future<String> getCurrentThemeMode() async {
    return await _storage.get(key: _themeKey) ?? AppConfig.defaultThemeMode;
  }
}
