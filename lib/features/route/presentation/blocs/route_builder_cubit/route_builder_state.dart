part of 'route_builder_cubit.dart';

sealed class RouteBuilderState extends Equatable {
  const RouteBuilderState();
}

class RouteBuilderInactiveState extends RouteBuilderState {
  const RouteBuilderInactiveState();

  @override
  List<Object?> get props => [];
}

class RouteBuilderSelectingDestinationState extends RouteBuilderState {
  const RouteBuilderSelectingDestinationState({required this.origin});

  final GeocodeResult origin;

  @override
  List<Object?> get props => [origin];
}

class RouteBuilderLoadingState extends RouteBuilderState {
  const RouteBuilderLoadingState({
    required this.origin,
    required this.destination,
  });

  final GeocodeResult origin;
  final GeocodeResult destination;

  @override
  List<Object?> get props => [origin, destination];
}

class RouteBuilderLoadedState extends RouteBuilderState {
  const RouteBuilderLoadedState({
    required this.origin,
    required this.destination,
    required this.routeInfo,
  });

  final GeocodeResult origin;
  final GeocodeResult destination;
  final DrivingRouteInfo routeInfo;

  @override
  List<Object?> get props => [origin, destination, routeInfo];
}

class RouteBuilderFailureState extends RouteBuilderState {
  const RouteBuilderFailureState({
    required this.origin,
    required this.destination,
    required this.failure,
  });

  final GeocodeResult origin;
  final GeocodeResult destination;
  final Object? failure;

  @override
  List<Object?> get props => [origin, destination, failure];
}

extension RouteBuilderStateX on RouteBuilderState {
  MapPoint? get originPoint => switch (this) {
    RouteBuilderSelectingDestinationState(:final origin) => origin.point,
    RouteBuilderLoadingState(:final origin) => origin.point,
    RouteBuilderLoadedState(:final origin) => origin.point,
    RouteBuilderFailureState(:final origin) => origin.point,
    _ => null,
  };

  MapPoint? get destinationPoint => switch (this) {
    RouteBuilderLoadingState(:final destination) => destination.point,
    RouteBuilderLoadedState(:final destination) => destination.point,
    RouteBuilderFailureState(:final destination) => destination.point,
    _ => null,
  };
}
