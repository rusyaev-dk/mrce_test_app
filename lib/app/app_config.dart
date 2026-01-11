import 'package:flutter_app_template/core/core.dart';

final class AppConfig {
  static const String defaultLanguageCode = AppLanguages.ru;
  static const String defaultThemeMode = "system";
}

abstract class AppLanguages {
  static const String ru = "ru";
  static const String uz = "uz";

  static List<String> toList() => [ru, uz];
}

abstract class AppRoles {
  static const Role superAdmin = Role.superAdmin;
  static const Role admin = Role.admin;
  static const Role user = Role.user;

  static List<Role> toList() => [superAdmin, admin, user];
}
