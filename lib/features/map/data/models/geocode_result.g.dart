// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocode_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeocodeResultDtoImpl _$$GeocodeResultDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$GeocodeResultDtoImpl(
      address: json['address'] as String,
      point: MapPointDto.fromJson(json['point'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GeocodeResultDtoImplToJson(
        _$GeocodeResultDtoImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'point': instance.point,
    };
