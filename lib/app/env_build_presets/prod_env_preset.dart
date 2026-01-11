import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/data/data.dart';
import 'package:flutter_app_template/di/di.dart';
import 'package:flutter_app_template/features/auth/data/data.dart';
import 'package:flutter_app_template/features/settings/data/data.dart';
import 'package:flutter_app_template/features/theme_editor/data/data.dart';

final class ProdEnvPreset implements IAppEnvPreset {
  ProdEnvPreset({required AppScope appScope})
    : _appScope = appScope,
      _httpClient = DioHttpClient(
        dio: appScope.dio,
        apiConfig: appScope.apiConfig,
      );

  final AppScope _appScope;
  final IHttpClient _httpClient;

  @override
  IAuthRepo createAuthRepo() {
    _httpClient.hashCode;
    throw UnimplementedError();
    // return HttpAuthRepo(httpClient: _httpClient);
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
