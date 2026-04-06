import 'package:mrce_test_app/features/saved_addresses/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/domain/domain.dart';

class SavedAddressesInteractor {
  SavedAddressesInteractor({required ISavedAddressesRepo savedAddressesRepo})
    : _savedAddressesRepo = savedAddressesRepo;

  final ISavedAddressesRepo _savedAddressesRepo;

  Future<List<Address>> getAddresses() async {
    final addresses = await _savedAddressesRepo.getAddresses();
    return addresses;
  }

  Future<void> saveAddress(Address address) async {
    await _savedAddressesRepo.saveAddress(address);
  }

  Future<void> deleteAddress(String id) async {
    await _savedAddressesRepo.deleteAddress(id);
  }
}
