// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapPointDtoImpl _$$MapPointDtoImplFromJson(Map<String, dynamic> json) =>
    _$MapPointDtoImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$MapPointDtoImplToJson(_$MapPointDtoImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
