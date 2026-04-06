// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/features/map/data/data.dart';

class MapPoint extends Equatable {
  const MapPoint({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  factory MapPoint.fromDto(MapPointDto dto) =>
      MapPoint(latitude: dto.latitude, longitude: dto.longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}
