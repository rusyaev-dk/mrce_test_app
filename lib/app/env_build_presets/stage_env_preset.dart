import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/core/data/data.dart';
import 'package:mrce_test_app/di/di.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/data/data.dart';
import 'package:mrce_test_app/features/settings/data/data.dart';

final class StageEnvPreset implements IAppEnvPreset {
  StageEnvPreset({required AppScope appScope})
    : _appScope = appScope,
      _httpClient = DioHttpClient(
        dio: appScope.dio,
        apiConfig: appScope.apiConfig,
      );

  final AppScope _appScope;
  final IHttpClient _httpClient;

  @override
  ISettingsRepo createSettingsRepo() {
    return LocalSettingsRepo(
      storage: _appScope.storageAggregator.localKeyValueStorage,
    );
  }

  @override
  IGeocodeRepo createGeocodeRepo() {
    return HttpGeocodeRepo(httpClient: _httpClient);
  }

  @override
  ISavedAddressesRepo createSavedAddressesRepo() {
    return HiveSavedAddressesRepo(
      savedAddressesBox:
          _appScope.storageAggregator.hiveBoxes.savedAddressesBox,
    );
  }
}
