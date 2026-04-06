// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MapPointDto _$MapPointDtoFromJson(Map<String, dynamic> json) {
  return _MapPointDto.fromJson(json);
}

/// @nodoc
mixin _$MapPointDto {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapPointDtoCopyWith<MapPointDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapPointDtoCopyWith<$Res> {
  factory $MapPointDtoCopyWith(
          MapPointDto value, $Res Function(MapPointDto) then) =
      _$MapPointDtoCopyWithImpl<$Res, MapPointDto>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$MapPointDtoCopyWithImpl<$Res, $Val extends MapPointDto>
    implements $MapPointDtoCopyWith<$Res> {
  _$MapPointDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapPointDtoImplCopyWith<$Res>
    implements $MapPointDtoCopyWith<$Res> {
  factory _$$MapPointDtoImplCopyWith(
          _$MapPointDtoImpl value, $Res Function(_$MapPointDtoImpl) then) =
      __$$MapPointDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$MapPointDtoImplCopyWithImpl<$Res>
    extends _$MapPointDtoCopyWithImpl<$Res, _$MapPointDtoImpl>
    implements _$$MapPointDtoImplCopyWith<$Res> {
  __$$MapPointDtoImplCopyWithImpl(
      _$MapPointDtoImpl _value, $Res Function(_$MapPointDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$MapPointDtoImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapPointDtoImpl implements _MapPointDto {
  const _$MapPointDtoImpl({required this.latitude, required this.longitude});

  factory _$MapPointDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapPointDtoImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'MapPointDto(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapPointDtoImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapPointDtoImplCopyWith<_$MapPointDtoImpl> get copyWith =>
      __$$MapPointDtoImplCopyWithImpl<_$MapPointDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapPointDtoImplToJson(
      this,
    );
  }
}

abstract class _MapPointDto implements MapPointDto {
  const factory _MapPointDto(
      {required final double latitude,
      required final double longitude}) = _$MapPointDtoImpl;

  factory _MapPointDto.fromJson(Map<String, dynamic> json) =
      _$MapPointDtoImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$MapPointDtoImplCopyWith<_$MapPointDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
