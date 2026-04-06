import 'package:mrce_test_app/features/saved_addresses/domain/domain.dart';

abstract interface class ISavedAddressesRepo {
  Future<List<Address>> getAddresses();
  Future<void> saveAddress(Address address);
  Future<void> deleteAddress(String id);
}
