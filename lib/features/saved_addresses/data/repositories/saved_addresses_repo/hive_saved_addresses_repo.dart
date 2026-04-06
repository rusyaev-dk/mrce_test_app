import 'package:hive_flutter/hive_flutter.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/data/models/address.dart';
import 'package:mrce_test_app/features/saved_addresses/data/repositories/saved_addresses_repo/i_saved_addresses_repo.dart';
import 'package:mrce_test_app/features/saved_addresses/domain/domain.dart';

class HiveSavedAddressesRepo implements ISavedAddressesRepo {
  HiveSavedAddressesRepo({required Box<AddressDto> savedAddressesBox})
    : _savedAddressesBox = savedAddressesBox;

  final Box<AddressDto> _savedAddressesBox;

  @override
  Future<List<Address>> getAddresses() async {
    final addressesDto = _savedAddressesBox.values.toList();
    return addressesDto.map(Address.fromDto).toList();
  }

  @override
  Future<void> saveAddress(Address address) async {
    if (address.id.isEmpty) {
      throw ArgumentError('Address id must be a non-empty String');
    }
    await _savedAddressesBox.put(
      address.id,
      AddressDto(
        id: address.id,
        name: address.name,
        address: address.address,
        point: MapPointDto(
          latitude: address.point.latitude,
          longitude: address.point.longitude,
        ),
        createdAt: address.createdAt,
      ),
    );
  }

  @override
  Future<void> deleteAddress(String id) async {
    await _savedAddressesBox.delete(id);
  }
}
