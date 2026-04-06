import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/di/di.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/data/data.dart';
import 'package:mrce_test_app/features/settings/data/data.dart';

abstract interface class IAppEnvPreset {
  ISettingsRepo createSettingsRepo();

  IGeocodeRepo createGeocodeRepo();
  ISavedAddressesRepo createSavedAddressesRepo();
}

sealed class AppEnvPresetsFactory {
  static IAppEnvPreset create({required AppScope appScope}) {
    switch (appScope.envType) {
      case AppEnvType.dev:
        return DevEnvPreset(appScope: appScope);
      case AppEnvType.stage:
        return StageEnvPreset(appScope: appScope);
      case AppEnvType.prod:
        return ProdEnvPreset(appScope: appScope);
    }
  }
}
