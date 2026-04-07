import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/route_builder/domain/domain.dart';

part 'route_builder_state.dart';

class RouteBuilderCubit extends Cubit<RouteBuilderState> {
  RouteBuilderCubit({
    required RouteInteractor routeInteractor,
    required ILogger logger,
  }) : _routeInteractor = routeInteractor,
       _logger = logger,
       super(const RouteBuilderInactiveState());

  final RouteInteractor _routeInteractor;
  final ILogger _logger;

  void startRouteBuilding(GeocodeResult origin) {
    emit(RouteBuilderSelectingDestinationState(origin: origin));
  }

  Future<void> buildRoute(GeocodeResult destination) async {
    final currentState = state;
    if (currentState is! RouteBuilderSelectingDestinationState) return;
    final origin = currentState.origin;

    emit(RouteBuilderLoadingState(origin: origin, destination: destination));

    try {
      final routeInfo = await _routeInteractor.buildRoute(
        origin: origin.point,
        destination: destination.point,
      );
      emit(
        RouteBuilderLoadedState(
          origin: origin,
          destination: destination,
          routeInfo: routeInfo,
        ),
      );
    } catch (e, st) {
      _logger.exception(e, st);
      emit(
        RouteBuilderFailureState(
          origin: origin,
          destination: destination,
          failure: e is AppException
              ? e
              : AppUnknownException(message: e.toString(), stackTrace: st),
        ),
      );
    }
  }

  void cancel() {
    emit(const RouteBuilderInactiveState());
  }
}
