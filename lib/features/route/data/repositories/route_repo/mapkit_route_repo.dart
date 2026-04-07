import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/route/data/data.dart';
import 'package:mrce_test_app/features/route/domain/domain.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapkitRouteRepo implements IRouteRepo {
  @override
  Future<DrivingRouteInfo> buildRoute({
    required MapPoint origin,
    required MapPoint destination,
  }) async {
    final requestPoints = [
      RequestPoint(
        point: Point(latitude: origin.latitude, longitude: origin.longitude),
        requestPointType: RequestPointType.wayPoint,
      ),
      RequestPoint(
        point: Point(
          latitude: destination.latitude,
          longitude: destination.longitude,
        ),
        requestPointType: RequestPointType.wayPoint,
      ),
    ];

    final (session, request) = await YandexDriving.requestRoutes(
      points: requestPoints,
      drivingOptions: const DrivingOptions(routesCount: 1),
    );

    final result = await request;
    await session.close();

    if (result.error != null) {
      throw Exception(result.error);
    }

    final routes = result.routes;
    if (routes == null || routes.isEmpty) {
      throw const FormatException('Route not found');
    }

    final route = routes.first;
    final polylinePoints = route.geometry.points
        .map((p) => MapPointDto(latitude: p.latitude, longitude: p.longitude))
        .toList();

    final weight = route.metadata.weight;

    return DrivingRouteInfo.fromDto(
      DrivingRouteInfoDto(
        polylinePoints: polylinePoints,
        distanceMeters: weight.distance.value ?? 0,
        durationSeconds: weight.time.value ?? 0,
        distanceText: weight.distance.text,
        durationText: weight.timeWithTraffic.text,
      ),
    );
  }
}
