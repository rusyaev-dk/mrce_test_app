import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/geocode_caching/data/data.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';

class GeocodeInteractor {
  GeocodeInteractor({
    required IGeocodeRepo geocodeRepo,
    required ICachedGeocodeRepo cachedGeocodeRepo,
    required ILogger logger,
  }) : _geocodeRepo = geocodeRepo,
       _cachedGeocodeRepo = cachedGeocodeRepo,
       _logger = logger;

  final IGeocodeRepo _geocodeRepo;
  final ICachedGeocodeRepo _cachedGeocodeRepo;
  final ILogger _logger;

  Future<GeocodeResult> getGeocode(MapPoint point) async {
    try {
      final cachedResult = await _cachedGeocodeRepo.getByPoint(point);
      if (cachedResult != null) {
        _logger.log(
          'Cached geocode result found for point ${point.latitude},${point.longitude}',
        );
        return cachedResult;
      }
    } catch (e, st) {
      _logger.exception(e, st);
    }

    final httpResult = await _geocodeRepo.getGeocode(point);
    try {
      await _cachedGeocodeRepo.put(httpResult);
    } catch (e, st) {
      _logger.exception(e, st);
    }
    return httpResult;
  }
}
