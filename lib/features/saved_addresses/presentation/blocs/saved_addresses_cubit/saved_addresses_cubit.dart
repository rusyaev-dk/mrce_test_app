import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/saved_addresses/domain/domain.dart';
import 'package:uuid/uuid.dart';

part 'saved_addresses_state.dart';

class SavedAddressesCubit extends Cubit<SavedAddressesState> {
  SavedAddressesCubit({
    required SavedAddressesInteractor savedAddressesInteractor,
  }) : _savedAddressesInteractor = savedAddressesInteractor,
       super(const SavedAddressesInitialState());

  final SavedAddressesInteractor _savedAddressesInteractor;

  Future<void> getAddresses() async {
    try {
      if (state is! SavedAddressesLoadingState) {
        emit(const SavedAddressesLoadingState());
      }
      final addresses = await _savedAddressesInteractor.getAddresses();
      emit(SavedAddressesLoadedState(addresses: addresses));
    } catch (e, st) {
      emit(
        SavedAddressesFailureState(
          failure: e is AppException
              ? e
              : AppUnknownException(message: e.toString(), stackTrace: st),
        ),
      );
    }
  }

  Future<void> saveGeocodeResult(
    GeocodeResult geocodeResult,
    String name,
  ) async {
    try {
      final address = Address(
        id: const Uuid().v4(),
        name: name,
        address: geocodeResult.address,
        point: geocodeResult.point,
        createdAt: DateTime.now(),
      );
      await _savedAddressesInteractor.saveAddress(address);
      await getAddresses();
    } catch (e, st) {
      emit(
        SavedAddressesFailureState(
          failure: e is AppException
              ? e
              : AppUnknownException(message: e.toString(), stackTrace: st),
        ),
      );
    }
  }

  Future<void> deleteAddress(String id) async {
    try {
      await _savedAddressesInteractor.deleteAddress(id);
      await getAddresses();
    } catch (e, st) {
      emit(
        SavedAddressesFailureState(
          failure: e is AppException
              ? e
              : AppUnknownException(message: e.toString(), stackTrace: st),
        ),
      );
    }
  }
}
