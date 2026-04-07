import 'package:mrce_test_app/features/map/domain/domain.dart';

final class GeocodeCacheEntryDto {
  const GeocodeCacheEntryDto({
    required this.key,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.updatedAtMs,
    required this.lastAccessedAtMs,
  });

  final String key;
  final String address;
  final double latitude;
  final double longitude;
  final int updatedAtMs;
  final int lastAccessedAtMs;

  GeocodeResult toDomain() {
    return GeocodeResult(
      address: address,
      point: MapPoint(latitude: latitude, longitude: longitude),
    );
  }

  GeocodeCacheEntryDto copyWithLastAccessedAtMs(int value) {
    return GeocodeCacheEntryDto(
      key: key,
      address: address,
      latitude: latitude,
      longitude: longitude,
      updatedAtMs: updatedAtMs,
      lastAccessedAtMs: value,
    );
  }
}
