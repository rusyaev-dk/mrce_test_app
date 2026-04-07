part of 'map_cubit.dart';

sealed class MapState extends Equatable {
  const MapState({required this.center, required this.isOffline});
  final MapPoint center;
  final bool isOffline;
}

class MapDraggingState extends MapState {
  const MapDraggingState({required super.center, required super.isOffline});

  @override
  List<Object?> get props => [center, isOffline];
}

class MapIdleState extends MapState {
  const MapIdleState({required super.center, required super.isOffline});

  @override
  List<Object?> get props => [center, isOffline];
}

class MapFailureState extends MapState {
  const MapFailureState({
    required super.center,
    required super.isOffline,
    required this.failure,
  });

  final Object? failure;

  @override
  List<Object?> get props => [center, isOffline, failure];
}
