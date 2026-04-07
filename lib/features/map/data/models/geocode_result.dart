import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mrce_test_app/features/map/data/data.dart';

part 'geocode_result.freezed.dart';
part 'geocode_result.g.dart';

@freezed
class GeocodeResultDto with _$GeocodeResultDto {
  const factory GeocodeResultDto({
    required String address,
    required MapPointDto point,
  }) = _GeocodeResultDto;

  factory GeocodeResultDto.fromJson(Map<String, dynamic> json) =>
      _$GeocodeResultDtoFromJson(json);
}