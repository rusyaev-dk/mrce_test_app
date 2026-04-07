part of 'geocode_bloc.dart';

sealed class GeocodeEvent extends Equatable {
  const GeocodeEvent();

  @override
  List<Object?> get props => [];
}

class RequestGeocodeEvent extends GeocodeEvent {
  const RequestGeocodeEvent({required this.point});
  final MapPoint point;

  @override
  List<Object?> get props => [point];
}

class ClearGeocodeEvent extends GeocodeEvent {
  const ClearGeocodeEvent();
}
