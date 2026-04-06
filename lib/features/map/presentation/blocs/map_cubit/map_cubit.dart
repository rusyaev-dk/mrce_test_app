import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit()
    : super(
        const MapIdleState(
          center: MapPoint(latitude: 41.2995, longitude: 69.2401),
        ),
      );

  void onCameraMove(MapPoint center) => emit(MapDraggingState(center: center));

  void onCameraIdle(MapPoint center) => emit(MapIdleState(center: center));
}
