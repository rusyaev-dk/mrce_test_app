import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'dart:async';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({
    required IConnectivityRepo connectivityRepo,
    required ILogger logger,
  }) : _connectivityRepo = connectivityRepo,
       _logger = logger,
       super(
         const MapIdleState(
           center: MapPoint(latitude: 41.2995, longitude: 69.2401),
           isOffline: false,
         ),
       ) {
    _isOnlineSub = _connectivityRepo.watchIsOnline().listen(
      _onConnectionChanged,
    );
    _syncInitialConnectivity();
  }

  final IConnectivityRepo _connectivityRepo;
  final ILogger _logger;
  StreamSubscription<bool>? _isOnlineSub;

  void onCameraMove(MapPoint center) {
    if (state.isOffline) return;
    if (state is MapDraggingState) return;
    emit(MapDraggingState(center: center, isOffline: false));
  }

  void onCameraIdle(MapPoint center) {
    if (state.isOffline) return;
    emit(MapIdleState(center: center, isOffline: false));
  }

  Future<void> _syncInitialConnectivity() async {
    try {
      final isOnline = await _connectivityRepo.isOnline();
      _onConnectionChanged(isOnline);
    } catch (e, st) {
      _logger.exception(e, st);
    }
  }

  void _onConnectionChanged(bool isOnline) {
    final isOffline = !isOnline;
    if (state.isOffline == isOffline) return;

    emit(switch (state) {
      MapDraggingState() => MapDraggingState(
        center: state.center,
        isOffline: isOffline,
      ),
      MapFailureState(:final failure) => MapFailureState(
        center: state.center,
        isOffline: isOffline,
        failure: failure,
      ),
      _ => MapIdleState(center: state.center, isOffline: isOffline),
    });
  }

  @override
  Future<void> close() async {
    await _isOnlineSub?.cancel();
    return super.close();
  }
}
