import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_point.freezed.dart';
part 'map_point.g.dart';

@freezed
class MapPointDto with _$MapPointDto {
  const factory MapPointDto({
    required double latitude,
    required double longitude,
  }) = _MapPointDto;

  factory MapPointDto.fromJson(Map<String, dynamic> json) =>
      _$MapPointDtoFromJson(json);
}