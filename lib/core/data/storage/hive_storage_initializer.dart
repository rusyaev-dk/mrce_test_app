import 'package:hive_flutter/hive_flutter.dart';
import 'package:mrce_test_app/features/saved_addresses/data/data.dart';

final class HiveBoxes {
  HiveBoxes({required this.savedAddressesBox});

  final Box<AddressDto> savedAddressesBox;
}

final class HiveStorageInitializer {
  static const String savedAddressesBoxName = 'saved_addresses';

  Future<HiveBoxes> init() async {
    await Hive.initFlutter();
    _registerAdapters();

    final savedAddressesBox = await Hive.openBox<AddressDto>(
      savedAddressesBoxName,
    );

    return HiveBoxes(savedAddressesBox: savedAddressesBox);
  }

  void _registerAdapters() {
    final adapter = AddressDtoAdapter();
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }
}
