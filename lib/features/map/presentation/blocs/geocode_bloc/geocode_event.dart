part of 'geocode_bloc.dart';

sealed class GeocodeEvent extends Equatable {
  const GeocodeEvent();
}

class RequestGeocodeEvent extends GeocodeEvent {
  const RequestGeocodeEvent({required this.point});
  final MapPoint point;

  @override
  List<Object?> get props => [point];
}
