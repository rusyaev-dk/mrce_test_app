import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';

class HttpGeocodeRepo implements IGeocodeRepo {
  HttpGeocodeRepo({required IHttpClient httpClient}) : _httpClient = httpClient;

  final IHttpClient _httpClient;

  @override
  Future<GeocodeResult> getGeocode(MapPoint point) async {
    _httpClient.hashCode;
    return GeocodeResult(address: 'test', point: point);
  }
}
