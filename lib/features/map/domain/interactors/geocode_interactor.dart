import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';

class GeocodeInteractor {
  GeocodeInteractor({required IGeocodeRepo geocodeRepo})
    : _geocodeRepo = geocodeRepo;
  final IGeocodeRepo _geocodeRepo;

  Future<GeocodeResult> getGeocode(MapPoint point) async {
    return _geocodeRepo.getGeocode(point);
  }
}
