import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/route/data/data.dart';
import 'package:mrce_test_app/features/route/domain/domain.dart';

class RouteInteractor {
  RouteInteractor({required IRouteRepo routeRepo}) : _routeRepo = routeRepo;

  final IRouteRepo _routeRepo;

  Future<DrivingRouteInfo> buildRoute({
    required MapPoint origin,
    required MapPoint destination,
  }) async {
    return _routeRepo.buildRoute(origin: origin, destination: destination);
  }
}
