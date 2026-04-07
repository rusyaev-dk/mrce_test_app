import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'address_validator_state.dart';

class AddressValidatorCubit extends Cubit<AddressValidatorState> {
  AddressValidatorCubit() : super(const AddressValidatorState());

  void validateName(String value) {
    final name = value.trim();

    if (name.isEmpty) {
      emit(
        const AddressValidatorState(
          errorText: 'Введите название',
        ),
      );
      return;
    }

    if (name.length > 32) {
      emit(
        AddressValidatorState(
          name: name,
          errorText: 'Максимум 32 символа',
        ),
      );
      return;
    }

    emit(AddressValidatorState(name: name, isValid: true));
  }
}
