import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/di/di.dart';
import 'package:flutter_app_template/features/auth/data/data.dart';
import 'package:flutter_app_template/features/settings/data/data.dart';
import 'package:flutter_app_template/features/theme_editor/data/data.dart';

final class DevEnvPreset implements IAppEnvPreset {
  DevEnvPreset({required AppScope appScope}) : _appScope = appScope;

  final AppScope _appScope;

  @override
  IAuthRepo createAuthRepo() {
    return const MockAuthRepo();
  }

  @override
  ISettingsRepo createSettingsRepo() {
    return LocalSettingsRepo(
      storage: _appScope.storageAggregator.localKeyValueStorage,
    );
  }

  @override
  IThemeEditorRepo createThemeEditorRepo() {
    return MockThemeEditorRepo();
  }
}
