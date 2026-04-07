import 'package:mrce_test_app/features/map/domain/domain.dart';

abstract interface class ICachedGeocodeRepo {
  Future<GeocodeResult?> getByPoint(MapPoint point);
  Future<void> put(GeocodeResult geocodeResult);
}
