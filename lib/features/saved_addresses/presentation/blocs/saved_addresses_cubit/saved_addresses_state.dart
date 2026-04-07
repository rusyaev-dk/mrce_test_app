part of 'saved_addresses_cubit.dart';

sealed class SavedAddressesState extends Equatable {
  const SavedAddressesState();

  @override
  List<Object?> get props => [];
}

class SavedAddressesInitialState extends SavedAddressesState {
  const SavedAddressesInitialState();
}

class SavedAddressesLoadingState extends SavedAddressesState {
  const SavedAddressesLoadingState();
}

class SavedAddressesLoadedState extends SavedAddressesState {
  const SavedAddressesLoadedState({required this.addresses});
  final List<Address> addresses;

  @override
  List<Object?> get props => [addresses];
}

class SavedAddressesFailureState extends SavedAddressesState {
  const SavedAddressesFailureState({required this.failure});
  final Object? failure;

  @override
  List<Object?> get props => [failure];
}
