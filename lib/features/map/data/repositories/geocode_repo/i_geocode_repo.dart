import 'package:mrce_test_app/features/map/domain/domain.dart';

abstract interface class IGeocodeRepo {
  Future<GeocodeResult> getGeocode(MapPoint point);
}
