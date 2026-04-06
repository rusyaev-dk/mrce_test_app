part of 'map_cubit.dart';

sealed class MapState extends Equatable {
  const MapState({required this.center});
  final MapPoint center;
}

class MapDraggingState extends MapState {
  const MapDraggingState({required super.center});

  @override
  List<Object?> get props => [center];
}

class MapIdleState extends MapState {
  const MapIdleState({required super.center});

  @override
  List<Object?> get props => [center];
}

class MapFailureState extends MapState {
  const MapFailureState({required super.center, required this.failure});

  final Object? failure;

  @override
  List<Object?> get props => [center];
}
