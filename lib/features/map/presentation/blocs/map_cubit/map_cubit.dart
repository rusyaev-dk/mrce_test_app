import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/core/data/data.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'dart:async';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({required IConnectivityRepo connectivityRepo})
    : _connectivityRepo = connectivityRepo,
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
  StreamSubscription<bool>? _isOnlineSub;

  void onCameraMove(MapPoint center) {
    if (state.isOffline) return;
    emit(MapDraggingState(center: center, isOffline: false));
  }

  void onCameraIdle(MapPoint center) {
    if (state.isOffline) return;
    emit(MapIdleState(center: center, isOffline: false));
  }

  Future<void> _syncInitialConnectivity() async {
    final isOnline = await _connectivityRepo.isOnline();
    _onConnectionChanged(isOnline);
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
