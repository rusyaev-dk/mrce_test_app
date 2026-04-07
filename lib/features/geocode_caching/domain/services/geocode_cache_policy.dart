import 'dart:math';

import 'package:mrce_test_app/features/map/domain/domain.dart';

final class GeocodeCachePolicy {
  const GeocodeCachePolicy({
    this.ttl = const Duration(days: 7),
    this.maxEntries = 1000,
    this.coordinatePrecision = 4,
  }) : assert(maxEntries > 0, 'maxEntries must be greater than zero'),
       assert(
         coordinatePrecision >= 0,
         'coordinatePrecision must be non-negative',
       );

  final Duration ttl;
  final int maxEntries;
  final int coordinatePrecision;

  String keyFor(MapPoint point) {
    final normalizedLat = _normalize(point.latitude);
    final normalizedLon = _normalize(point.longitude);
    return '$normalizedLat:$normalizedLon';
  }

  bool isExpired(DateTime updatedAt, DateTime now) {
    return now.difference(updatedAt) > ttl;
  }

  double normalizeCoordinate(double value) {
    final factor = pow(10, coordinatePrecision).toDouble();
    return (value * factor).roundToDouble() / factor;
  }

  String _normalize(double value) {
    final normalized = normalizeCoordinate(value);
    return normalized.toStringAsFixed(coordinatePrecision);
  }
}
