// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/route/data/data.dart';

class DrivingRouteInfo extends Equatable {
  const DrivingRouteInfo({
    required this.polylinePoints,
    required this.distanceMeters,
    required this.durationSeconds,
    required this.distanceText,
    required this.durationText,
  });

  final List<MapPoint> polylinePoints;
  final double distanceMeters;
  final double durationSeconds;
  final String distanceText;
  final String durationText;

  factory DrivingRouteInfo.fromDto(DrivingRouteInfoDto dto) =>
      DrivingRouteInfo(
        polylinePoints: dto.polylinePoints.map(MapPoint.fromDto).toList(),
        distanceMeters: dto.distanceMeters,
        durationSeconds: dto.durationSeconds,
        distanceText: dto.distanceText,
        durationText: dto.durationText,
      );

  @override
  List<Object?> get props => [
    polylinePoints,
    distanceMeters,
    durationSeconds,
    distanceText,
    durationText,
  ];
}
