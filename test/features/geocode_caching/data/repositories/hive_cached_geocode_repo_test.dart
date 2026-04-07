import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mrce_test_app/features/geocode_caching/data/data.dart';
import 'package:mrce_test_app/features/geocode_caching/domain/domain.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';

void main() {
  late Directory tempDir;
  late Box<GeocodeCacheEntryDto> box;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('geocode_cache_test_');
    Hive.init(tempDir.path);
    final adapter = GeocodeCacheEntryDtoAdapter();
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
    box = await Hive.openBox<GeocodeCacheEntryDto>('geocode_cache_test_box');
  });

  tearDown(() async {
    await box.clear();
    await box.close();
    await Hive.deleteBoxFromDisk('geocode_cache_test_box');
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  test('returns cached result for fresh entry', () async {
    final repo = HiveCachedGeocodeRepo(
      geocodeCacheBox: box,
      cachePolicy: const GeocodeCachePolicy(
        ttl: Duration(days: 1),
        coordinatePrecision: 5,
      ),
      now: () => DateTime(2026, 4, 7, 12, 0, 0),
    );
    const point = MapPoint(latitude: 55.755826, longitude: 37.6173);
    const result = GeocodeResult(address: 'Moscow', point: point);

    await repo.put(result);
    final cached = await repo.getByPoint(point);

    expect(
      cached,
      const GeocodeResult(
        address: 'Moscow',
        point: MapPoint(latitude: 55.75583, longitude: 37.6173),
      ),
    );
  });

  test('returns null for expired entry', () async {
    final repo = HiveCachedGeocodeRepo(
      geocodeCacheBox: box,
      cachePolicy: const GeocodeCachePolicy(ttl: Duration(minutes: 1)),
      now: () => DateTime(2026, 4, 7, 12, 0, 0),
    );
    const point = MapPoint(latitude: 40.7128, longitude: -74.0060);
    const result = GeocodeResult(address: 'New York', point: point);

    await repo.put(result);

    final expiredRepo = HiveCachedGeocodeRepo(
      geocodeCacheBox: box,
      cachePolicy: const GeocodeCachePolicy(ttl: Duration(minutes: 1)),
      now: () => DateTime(2026, 4, 7, 12, 2, 0),
    );

    final cached = await expiredRepo.getByPoint(point);
    expect(cached, isNull);
    expect(box.isEmpty, isTrue);
  });

  test('prunes oldest entries when over max entries', () async {
    DateTime now = DateTime(2026, 4, 7, 12, 0, 0);
    final repo = HiveCachedGeocodeRepo(
      geocodeCacheBox: box,
      cachePolicy: const GeocodeCachePolicy(maxEntries: 1),
      now: () => now,
    );

    await repo.put(
      const GeocodeResult(
        address: 'Address A',
        point: MapPoint(latitude: 1.0, longitude: 1.0),
      ),
    );
    now = now.add(const Duration(minutes: 1));
    await repo.put(
      const GeocodeResult(
        address: 'Address B',
        point: MapPoint(latitude: 2.0, longitude: 2.0),
      ),
    );

    expect(box.length, 1);
    final values = box.values.toList();
    expect(values.single.address, 'Address B');
  });
}
