import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';

part 'geocode_event.dart';
part 'geocode_state.dart';

class GeocodeBloc extends Bloc<GeocodeEvent, GeocodeState> {
  GeocodeBloc() : super(const GeocodeInitialState());
}
