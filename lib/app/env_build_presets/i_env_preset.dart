import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/di/di.dart';
import 'package:flutter_app_template/features/auth/data/data.dart';
import 'package:flutter_app_template/features/settings/data/data.dart';
import 'package:flutter_app_template/features/theme_editor/data/data.dart';

abstract interface class IAppEnvPreset {
  IAuthRepo createAuthRepo();

  ISettingsRepo createSettingsRepo();
  IThemeEditorRepo createThemeEditorRepo();
}

sealed class AppEnvPresetsFactory {
  static IAppEnvPreset create({required AppScope appScope}) {
    switch (appScope.env) {
      case AppEnvType.dev:
        return DevEnvPreset(appScope: appScope);
      case AppEnvType.stage:
        return StageEnvPreset(appScope: appScope);
      case AppEnvType.prod:
        return ProdEnvPreset(appScope: appScope);
    }
  }
}
