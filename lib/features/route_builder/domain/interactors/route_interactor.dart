import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/route_builder/data/data.dart';
import 'package:mrce_test_app/features/route_builder/domain/domain.dart';

class RouteInteractor {
  RouteInteractor({required IRouteRepo routeRepo, required ILogger logger})
    : _routeRepo = routeRepo,
      _logger = logger;

  final IRouteRepo _routeRepo;
  final ILogger _logger;

  Future<DrivingRouteInfo> buildRoute({
    required MapPoint origin,
    required MapPoint destination,
  }) async {
    _logger.log(
      'Building route from ${origin.latitude},${origin.longitude} to ${destination.latitude},${destination.longitude}',
    );
    return _routeRepo.buildRoute(origin: origin, destination: destination);
  }
}
