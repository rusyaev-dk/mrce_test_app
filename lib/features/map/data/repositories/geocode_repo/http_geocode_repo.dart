import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HttpGeocodeRepo implements IGeocodeRepo {
  HttpGeocodeRepo();

  @override
  Future<GeocodeResult> getGeocode(MapPoint point) async {
    final (session, request) = await YandexSearch.searchByPoint(
      point: Point(latitude: point.latitude, longitude: point.longitude),
      searchOptions: const SearchOptions(
        searchType: SearchType.geo,
        resultPageSize: 1,
      ),
    );
    final result = await request;
    await session.close();

    if (result.error != null && result.error!.isNotEmpty) {
      throw Exception(result.error);
    }

    final items = result.items;
    if (items == null || items.isEmpty) {
      throw const FormatException('Address not found');
    }

    final item = items.first;
    final address =
        item.toponymMetadata?.address.formattedAddress ??
        item.businessMetadata?.address.formattedAddress ??
        item.name;

    if (address.isEmpty) {
      throw const FormatException('Address is missing in response');
    }

    return GeocodeResult(address: address, point: point);
  }
}
