part of 'address_validator_cubit.dart';

class AddressValidatorState extends Equatable {
  const AddressValidatorState({
    this.name = '',
    this.errorText,
    this.isValid = false,
  });

  final String name;
  final String? errorText;
  final bool isValid;

  @override
  List<Object?> get props => [name, errorText, isValid];
}
