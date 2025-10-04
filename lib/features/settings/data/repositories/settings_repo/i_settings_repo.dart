abstract interface class ISettingsRepo {
  Future<bool> changeLocale(String newLocale);
  Future<String> getCurrentLocale();

  Future<bool> changeThemeMode(String themeCode);
  Future<String> getCurrentThemeMode();
}
