import 'package:hive_flutter/hive_flutter.dart';
import 'package:mrce_test_app/features/geocode_caching/data/models/geocode_cache_entry_dto.dart';

class GeocodeCacheEntryDtoAdapter extends TypeAdapter<GeocodeCacheEntryDto> {
  @override
  final int typeId = 10;

  @override
  GeocodeCacheEntryDto read(BinaryReader reader) {
    return GeocodeCacheEntryDto(
      key: reader.readString(),
      address: reader.readString(),
      latitude: reader.readDouble(),
      longitude: reader.readDouble(),
      updatedAtMs: reader.readInt(),
      lastAccessedAtMs: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, GeocodeCacheEntryDto obj) {
    writer
      ..writeString(obj.key)
      ..writeString(obj.address)
      ..writeDouble(obj.latitude)
      ..writeDouble(obj.longitude)
      ..writeInt(obj.updatedAtMs)
      ..writeInt(obj.lastAccessedAtMs);
  }
}
