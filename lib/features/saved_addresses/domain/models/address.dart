// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/saved_addresses/data/data.dart';

class Address extends Equatable {
  const Address({
    required this.id,
    required this.name,
    required this.address,
    required this.point,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String address;
  final MapPoint point;
  final DateTime createdAt;

  factory Address.fromDto(AddressDto dto) => Address(
    id: dto.id,
    name: dto.name,
    address: dto.address,
    point: MapPoint.fromDto(dto.point),
    createdAt: dto.createdAt,
  );

  @override
  List<Object?> get props => [id, name, address, point, createdAt];
}
