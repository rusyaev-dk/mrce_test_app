import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/di/di.dart';
import 'package:mrce_test_app/features/geocode_caching/data/data.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/route_builder/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/data/data.dart';

abstract interface class IAppEnvPreset {
  IGeocodeRepo createGeocodeRepo();
  ICachedGeocodeRepo createCachedGeocodeRepo();
  ISavedAddressesRepo createSavedAddressesRepo();
  IRouteRepo createRouteRepo();
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
