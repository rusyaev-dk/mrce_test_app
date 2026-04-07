import 'package:hive_flutter/hive_flutter.dart';
import 'package:mrce_test_app/features/geocode_caching/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/data/data.dart';

final class HiveBoxes {
  HiveBoxes({required this.savedAddressesBox, required this.geocodeCacheBox});

  final Box<AddressDto> savedAddressesBox;
  final Box<GeocodeCacheEntryDto> geocodeCacheBox;
}

final class HiveStorageInitializer {
  static const String savedAddressesBoxName = 'saved_addresses';
  static const String geocodeCacheBoxName = 'geocode_cache';

  Future<HiveBoxes> init() async {
    await Hive.initFlutter();
    _registerAdapters();

    final savedAddressesBox = await Hive.openBox<AddressDto>(
      savedAddressesBoxName,
    );
    final geocodeCacheBox = await Hive.openBox<GeocodeCacheEntryDto>(
      geocodeCacheBoxName,
    );

    return HiveBoxes(
      savedAddressesBox: savedAddressesBox,
      geocodeCacheBox: geocodeCacheBox,
    );
  }

  void _registerAdapters() {
    Hive
      ..registerAdapter(AddressDtoAdapter(), override: true)
      ..registerAdapter(GeocodeCacheEntryDtoAdapter(), override: true);
  }

}
