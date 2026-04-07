import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/saved_addresses/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/domain/domain.dart';

class SavedAddressesInteractor {
  SavedAddressesInteractor({
    required ISavedAddressesRepo savedAddressesRepo,
    required ILogger logger,
  }) : _savedAddressesRepo = savedAddressesRepo,
       _logger = logger;

  final ISavedAddressesRepo _savedAddressesRepo;
  final ILogger _logger;

  Future<List<Address>> getAddresses() async {
    final addresses = await _savedAddressesRepo.getAddresses();
    _logger.log('Fetched ${addresses.length} saved addresses');
    return addresses;
  }

  Future<void> saveAddress(Address address) async {
    await _savedAddressesRepo.saveAddress(address);
    _logger.log('Saved address with id ${address.id}');
  }

  Future<void> deleteAddress(String id) async {
    await _savedAddressesRepo.deleteAddress(id);
    _logger.log('Deleted address with id $id');
  }
}
