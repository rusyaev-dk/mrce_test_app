part of 'geocode_bloc.dart';

sealed class GeocodeState extends Equatable {
  const GeocodeState();
}

class GeocodeInitialState extends GeocodeState {
  const GeocodeInitialState();

  @override
  List<Object?> get props => [];
}

class GeocodeLoadingState extends GeocodeState {
  const GeocodeLoadingState();

  @override
  List<Object?> get props => [];
}

class GeocodeLoadedState extends GeocodeState {
  const GeocodeLoadedState({required this.result});
  final GeocodeResult result;

  @override
  List<Object?> get props => [result];
}

class GeocodeFailureState extends GeocodeState {
  const GeocodeFailureState({required this.failure});
  final Object? failure;

  @override
  List<Object?> get props => [failure];
}
