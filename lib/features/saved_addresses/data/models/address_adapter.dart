import 'package:hive_flutter/hive_flutter.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/data/models/address.dart';

class AddressDtoAdapter extends TypeAdapter<AddressDto> {
  @override
  final int typeId = 0;

  @override
  AddressDto read(BinaryReader reader) {
    return AddressDto(
      id: reader.readString(),
      name: reader.readString(),
      address: reader.readString(),
      point: MapPointDto(
        latitude: reader.readDouble(),
        longitude: reader.readDouble(),
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, AddressDto obj) {
    writer
      ..writeString(obj.id)
      ..writeString(obj.name)
      ..writeString(obj.address)
      ..writeDouble(obj.point.latitude)
      ..writeDouble(obj.point.longitude)
      ..writeInt(obj.createdAt.millisecondsSinceEpoch);
  }
}
