import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mrce_test_app/core/core.dart';

part 'address_validator_state.dart';

class AddressValidatorCubit extends Cubit<AddressValidatorState> {
  AddressValidatorCubit({required ILogger logger})
    : _logger = logger,
      super(const AddressValidatorState());

  final ILogger _logger;

  void validateName(String value) {
    final name = value.trim();
    _logger.log('Validating saved address name input');

    if (name.isEmpty) {
      emit(const AddressValidatorState(errorText: 'Введите название'));
      return;
    }

    if (name.length > 32) {
      emit(AddressValidatorState(name: name, errorText: 'Максимум 32 символа'));
      return;
    }

    emit(AddressValidatorState(name: name, isValid: true));
  }
}
