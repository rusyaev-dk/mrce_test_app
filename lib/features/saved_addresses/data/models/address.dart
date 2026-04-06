import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mrce_test_app/features/map/data/data.dart';

part 'address.freezed.dart';

@freezed
class AddressDto with _$AddressDto {
  const factory AddressDto({
    required String id,
    required String name,
    required String address,
    required MapPointDto point,
    required DateTime createdAt,
  }) = _AddressDto;
}
