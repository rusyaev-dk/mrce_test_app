// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';

class GeocodeResult extends Equatable {
  const GeocodeResult({required this.address, required this.point});

  final String address;
  final MapPoint point;

  factory GeocodeResult.fromDto(GeocodeResultDto dto) =>
      GeocodeResult(address: dto.address, point: MapPoint.fromDto(dto.point));

  @override
  List<Object?> get props => [address, point];
}
