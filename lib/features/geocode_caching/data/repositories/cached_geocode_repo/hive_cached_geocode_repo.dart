import 'package:hive_flutter/hive_flutter.dart';
import 'package:mrce_test_app/features/geocode_caching/data/models/models.dart';
import 'package:mrce_test_app/features/geocode_caching/data/repositories/cached_geocode_repo/i_cached_geocode_repo.dart';
import 'package:mrce_test_app/features/geocode_caching/domain/domain.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';

class HiveCachedGeocodeRepo implements ICachedGeocodeRepo {
  HiveCachedGeocodeRepo({
    required Box<GeocodeCacheEntryDto> geocodeCacheBox,
    required GeocodeCachePolicy cachePolicy,
    DateTime Function()? now,
  }) : _geocodeCacheBox = geocodeCacheBox,
       _cachePolicy = cachePolicy,
       _now = now ?? DateTime.now;

  final Box<GeocodeCacheEntryDto> _geocodeCacheBox;
  final GeocodeCachePolicy _cachePolicy;
  final DateTime Function() _now;

  @override
  Future<GeocodeResult?> getByPoint(MapPoint point) async {
    final key = _cachePolicy.keyFor(point);
    final entry = _geocodeCacheBox.get(key);
    if (entry == null) {
      return null;
    }

    final now = _now();
    final updatedAt = DateTime.fromMillisecondsSinceEpoch(entry.updatedAtMs);
    if (_cachePolicy.isExpired(updatedAt, now)) {
      await _geocodeCacheBox.delete(key);
      return null;
    }

    await _geocodeCacheBox.put(
      key,
      entry.copyWithLastAccessedAtMs(now.millisecondsSinceEpoch),
    );
    return entry.toDomain();
  }

  @override
  Future<void> put(GeocodeResult geocodeResult) async {
    final now = _now();
    final key = _cachePolicy.keyFor(geocodeResult.point);

    final entry = GeocodeCacheEntryDto(
      key: key,
      address: geocodeResult.address,
      latitude: _cachePolicy.normalizeCoordinate(geocodeResult.point.latitude),
      longitude: _cachePolicy.normalizeCoordinate(
        geocodeResult.point.longitude,
      ),
      updatedAtMs: now.millisecondsSinceEpoch,
      lastAccessedAtMs: now.millisecondsSinceEpoch,
    );

    await _geocodeCacheBox.put(key, entry);
    await _prune(now);
  }

  Future<void> _prune(DateTime now) async {
    final allEntries = _geocodeCacheBox.values.toList();

    final expiredKeys = <String>[];
    for (final entry in allEntries) {
      final updatedAt = DateTime.fromMillisecondsSinceEpoch(entry.updatedAtMs);
      if (_cachePolicy.isExpired(updatedAt, now)) {
        expiredKeys.add(entry.key);
      }
    }
    if (expiredKeys.isNotEmpty) {
      await _geocodeCacheBox.deleteAll(expiredKeys);
    }

    final overflow = _geocodeCacheBox.length - _cachePolicy.maxEntries;
    if (overflow <= 0) {
      return;
    }

    final entriesByOldest = _geocodeCacheBox.values.toList()
      ..sort((a, b) {
        final lastAccessCompare = a.lastAccessedAtMs.compareTo(
          b.lastAccessedAtMs,
        );
        if (lastAccessCompare != 0) {
          return lastAccessCompare;
        }
        return a.updatedAtMs.compareTo(b.updatedAtMs);
      });

    final keysToDelete = entriesByOldest
        .take(overflow)
        .map((entry) => entry.key)
        .toList();

    if (keysToDelete.isNotEmpty) {
      await _geocodeCacheBox.deleteAll(keysToDelete);
    }
  }
}
