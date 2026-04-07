import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/di/di.dart';
import 'package:mrce_test_app/features/geocode_caching/data/data.dart';
import 'package:mrce_test_app/features/geocode_caching/domain/domain.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/route_builder/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/data/data.dart';

final class DevEnvPreset implements IAppEnvPreset {
  DevEnvPreset({required AppScope appScope}) : _appScope = appScope;

  final AppScope _appScope;

  @override
  IGeocodeRepo createGeocodeRepo() {
    return HttpGeocodeRepo();
  }

  @override
  ISavedAddressesRepo createSavedAddressesRepo() {
    return HiveSavedAddressesRepo(
      savedAddressesBox:
          _appScope.storageAggregator.hiveBoxes.savedAddressesBox,
    );
  }

  @override
  IRouteRepo createRouteRepo() {
    return MapkitRouteRepo();
  }

  @override
  ICachedGeocodeRepo createCachedGeocodeRepo() {
    return HiveCachedGeocodeRepo(
      geocodeCacheBox: _appScope.storageAggregator.hiveBoxes.geocodeCacheBox,
      cachePolicy: const GeocodeCachePolicy(),
    );
  }
}
