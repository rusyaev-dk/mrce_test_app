abstract interface class ISettingsRepo {
  Future<bool> changeLanguageCode({required String newLanguageCode});
  Future<String> getCurrentLanguageCode();

  Future<bool> changeThemeMode({required String newThemeCode});
  Future<String> getCurrentThemeMode();
}
