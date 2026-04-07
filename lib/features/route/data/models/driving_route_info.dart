import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mrce_test_app/features/map/data/data.dart';

part 'driving_route_info.freezed.dart';

@freezed
class DrivingRouteInfoDto with _$DrivingRouteInfoDto {
  const factory DrivingRouteInfoDto({
    required List<MapPointDto> polylinePoints,
    required double distanceMeters,
    required double durationSeconds,
    required String distanceText,
    required String durationText,
  }) = _DrivingRouteInfoDto;
}
