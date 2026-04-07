import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/route_builder/domain/domain.dart';

abstract interface class IRouteRepo {
  Future<DrivingRouteInfo> buildRoute({
    required MapPoint origin,
    required MapPoint destination,
  });
}
