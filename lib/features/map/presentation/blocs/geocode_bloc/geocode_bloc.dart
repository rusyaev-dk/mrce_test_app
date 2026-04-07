import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:stream_transform/stream_transform.dart';

part 'geocode_event.dart';
part 'geocode_state.dart';

class GeocodeBloc extends Bloc<GeocodeEvent, GeocodeState> {
  GeocodeBloc({
    required GeocodeInteractor geocodeInteractor,
    required ILogger logger,
  }) : _geocodeInteractor = geocodeInteractor,
       _logger = logger,
       super(const GeocodeInitialState()) {
    on<RequestGeocodeEvent>(
      _onRequestGeocode,
      transformer: (events, mapper) =>
          events.debounce(const Duration(milliseconds: 500)).switchMap(mapper),
    );
    on<ClearGeocodeEvent>(_onClearGeocode);
  }

  final GeocodeInteractor _geocodeInteractor;
  final ILogger _logger;

  Future<void> _onRequestGeocode(
    RequestGeocodeEvent event,
    Emitter<GeocodeState> emit,
  ) async {
    try {
      if (state is! GeocodeLoadingState) {
        emit(const GeocodeLoadingState());
      }

      final result = await _geocodeInteractor.getGeocode(event.point);
      emit(GeocodeLoadedState(result: result));
    } catch (e, st) {
      _logger.exception(e, st);
      emit(
        GeocodeFailureState(
          failure: e is AppException
              ? e
              : AppUnknownException(message: e.toString(), stackTrace: st),
        ),
      );
    }
  }

  void _onClearGeocode(ClearGeocodeEvent event, Emitter<GeocodeState> emit) {
    if (state is GeocodeInitialState) return;
    emit(const GeocodeInitialState());
  }
}
