// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geocode_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GeocodeResultDto _$GeocodeResultDtoFromJson(Map<String, dynamic> json) {
  return _GeocodeResultDto.fromJson(json);
}

/// @nodoc
mixin _$GeocodeResultDto {
  String get address => throw _privateConstructorUsedError;
  MapPointDto get point => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeocodeResultDtoCopyWith<GeocodeResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeocodeResultDtoCopyWith<$Res> {
  factory $GeocodeResultDtoCopyWith(
          GeocodeResultDto value, $Res Function(GeocodeResultDto) then) =
      _$GeocodeResultDtoCopyWithImpl<$Res, GeocodeResultDto>;
  @useResult
  $Res call({String address, MapPointDto point});

  $MapPointDtoCopyWith<$Res> get point;
}

/// @nodoc
class _$GeocodeResultDtoCopyWithImpl<$Res, $Val extends GeocodeResultDto>
    implements $GeocodeResultDtoCopyWith<$Res> {
  _$GeocodeResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? point = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as MapPointDto,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MapPointDtoCopyWith<$Res> get point {
    return $MapPointDtoCopyWith<$Res>(_value.point, (value) {
      return _then(_value.copyWith(point: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GeocodeResultDtoImplCopyWith<$Res>
    implements $GeocodeResultDtoCopyWith<$Res> {
  factory _$$GeocodeResultDtoImplCopyWith(_$GeocodeResultDtoImpl value,
          $Res Function(_$GeocodeResultDtoImpl) then) =
      __$$GeocodeResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, MapPointDto point});

  @override
  $MapPointDtoCopyWith<$Res> get point;
}

/// @nodoc
class __$$GeocodeResultDtoImplCopyWithImpl<$Res>
    extends _$GeocodeResultDtoCopyWithImpl<$Res, _$GeocodeResultDtoImpl>
    implements _$$GeocodeResultDtoImplCopyWith<$Res> {
  __$$GeocodeResultDtoImplCopyWithImpl(_$GeocodeResultDtoImpl _value,
      $Res Function(_$GeocodeResultDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? point = null,
  }) {
    return _then(_$GeocodeResultDtoImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as MapPointDto,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeocodeResultDtoImpl implements _GeocodeResultDto {
  const _$GeocodeResultDtoImpl({required this.address, required this.point});

  factory _$GeocodeResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeocodeResultDtoImplFromJson(json);

  @override
  final String address;
  @override
  final MapPointDto point;

  @override
  String toString() {
    return 'GeocodeResultDto(address: $address, point: $point)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeocodeResultDtoImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.point, point) || other.point == point));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, point);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeocodeResultDtoImplCopyWith<_$GeocodeResultDtoImpl> get copyWith =>
      __$$GeocodeResultDtoImplCopyWithImpl<_$GeocodeResultDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeocodeResultDtoImplToJson(
      this,
    );
  }
}

abstract class _GeocodeResultDto implements GeocodeResultDto {
  const factory _GeocodeResultDto(
      {required final String address,
      required final MapPointDto point}) = _$GeocodeResultDtoImpl;

  factory _GeocodeResultDto.fromJson(Map<String, dynamic> json) =
      _$GeocodeResultDtoImpl.fromJson;

  @override
  String get address;
  @override
  MapPointDto get point;
  @override
  @JsonKey(ignore: true)
  _$$GeocodeResultDtoImplCopyWith<_$GeocodeResultDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
