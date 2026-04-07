// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driving_route_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DrivingRouteInfoDto {
  List<MapPointDto> get polylinePoints => throw _privateConstructorUsedError;
  double get distanceMeters => throw _privateConstructorUsedError;
  double get durationSeconds => throw _privateConstructorUsedError;
  String get distanceText => throw _privateConstructorUsedError;
  String get durationText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DrivingRouteInfoDtoCopyWith<DrivingRouteInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrivingRouteInfoDtoCopyWith<$Res> {
  factory $DrivingRouteInfoDtoCopyWith(
          DrivingRouteInfoDto value, $Res Function(DrivingRouteInfoDto) then) =
      _$DrivingRouteInfoDtoCopyWithImpl<$Res, DrivingRouteInfoDto>;
  @useResult
  $Res call(
      {List<MapPointDto> polylinePoints,
      double distanceMeters,
      double durationSeconds,
      String distanceText,
      String durationText});
}

/// @nodoc
class _$DrivingRouteInfoDtoCopyWithImpl<$Res, $Val extends DrivingRouteInfoDto>
    implements $DrivingRouteInfoDtoCopyWith<$Res> {
  _$DrivingRouteInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? polylinePoints = null,
    Object? distanceMeters = null,
    Object? durationSeconds = null,
    Object? distanceText = null,
    Object? durationText = null,
  }) {
    return _then(_value.copyWith(
      polylinePoints: null == polylinePoints
          ? _value.polylinePoints
          : polylinePoints // ignore: cast_nullable_to_non_nullable
              as List<MapPointDto>,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      distanceText: null == distanceText
          ? _value.distanceText
          : distanceText // ignore: cast_nullable_to_non_nullable
              as String,
      durationText: null == durationText
          ? _value.durationText
          : durationText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DrivingRouteInfoDtoImplCopyWith<$Res>
    implements $DrivingRouteInfoDtoCopyWith<$Res> {
  factory _$$DrivingRouteInfoDtoImplCopyWith(_$DrivingRouteInfoDtoImpl value,
          $Res Function(_$DrivingRouteInfoDtoImpl) then) =
      __$$DrivingRouteInfoDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<MapPointDto> polylinePoints,
      double distanceMeters,
      double durationSeconds,
      String distanceText,
      String durationText});
}

/// @nodoc
class __$$DrivingRouteInfoDtoImplCopyWithImpl<$Res>
    extends _$DrivingRouteInfoDtoCopyWithImpl<$Res, _$DrivingRouteInfoDtoImpl>
    implements _$$DrivingRouteInfoDtoImplCopyWith<$Res> {
  __$$DrivingRouteInfoDtoImplCopyWithImpl(_$DrivingRouteInfoDtoImpl _value,
      $Res Function(_$DrivingRouteInfoDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? polylinePoints = null,
    Object? distanceMeters = null,
    Object? durationSeconds = null,
    Object? distanceText = null,
    Object? durationText = null,
  }) {
    return _then(_$DrivingRouteInfoDtoImpl(
      polylinePoints: null == polylinePoints
          ? _value._polylinePoints
          : polylinePoints // ignore: cast_nullable_to_non_nullable
              as List<MapPointDto>,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      distanceText: null == distanceText
          ? _value.distanceText
          : distanceText // ignore: cast_nullable_to_non_nullable
              as String,
      durationText: null == durationText
          ? _value.durationText
          : durationText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DrivingRouteInfoDtoImpl implements _DrivingRouteInfoDto {
  const _$DrivingRouteInfoDtoImpl(
      {required final List<MapPointDto> polylinePoints,
      required this.distanceMeters,
      required this.durationSeconds,
      required this.distanceText,
      required this.durationText})
      : _polylinePoints = polylinePoints;

  final List<MapPointDto> _polylinePoints;
  @override
  List<MapPointDto> get polylinePoints {
    if (_polylinePoints is EqualUnmodifiableListView) return _polylinePoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_polylinePoints);
  }

  @override
  final double distanceMeters;
  @override
  final double durationSeconds;
  @override
  final String distanceText;
  @override
  final String durationText;

  @override
  String toString() {
    return 'DrivingRouteInfoDto(polylinePoints: $polylinePoints, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, distanceText: $distanceText, durationText: $durationText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrivingRouteInfoDtoImpl &&
            const DeepCollectionEquality()
                .equals(other._polylinePoints, _polylinePoints) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.distanceText, distanceText) ||
                other.distanceText == distanceText) &&
            (identical(other.durationText, durationText) ||
                other.durationText == durationText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_polylinePoints),
      distanceMeters,
      durationSeconds,
      distanceText,
      durationText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DrivingRouteInfoDtoImplCopyWith<_$DrivingRouteInfoDtoImpl> get copyWith =>
      __$$DrivingRouteInfoDtoImplCopyWithImpl<_$DrivingRouteInfoDtoImpl>(
          this, _$identity);
}

abstract class _DrivingRouteInfoDto implements DrivingRouteInfoDto {
  const factory _DrivingRouteInfoDto(
      {required final List<MapPointDto> polylinePoints,
      required final double distanceMeters,
      required final double durationSeconds,
      required final String distanceText,
      required final String durationText}) = _$DrivingRouteInfoDtoImpl;

  @override
  List<MapPointDto> get polylinePoints;
  @override
  double get distanceMeters;
  @override
  double get durationSeconds;
  @override
  String get distanceText;
  @override
  String get durationText;
  @override
  @JsonKey(ignore: true)
  _$$DrivingRouteInfoDtoImplCopyWith<_$DrivingRouteInfoDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
