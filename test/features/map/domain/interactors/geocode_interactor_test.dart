import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/geocode_caching/data/data.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';

class _MockGeocodeRepo extends Mock implements IGeocodeRepo {}

class _MockCachedGeocodeRepo extends Mock implements ICachedGeocodeRepo {}

class _MockLogger extends Mock implements ILogger {}

void main() {
  late _MockGeocodeRepo geocodeRepo;
  late _MockCachedGeocodeRepo cachedGeocodeRepo;
  late _MockLogger logger;
  late GeocodeInteractor interactor;

  const point = MapPoint(latitude: 55.7558, longitude: 37.6176);
  const cachedResult = GeocodeResult(address: 'Cached address', point: point);
  const httpResult = GeocodeResult(address: 'Http address', point: point);

  setUpAll(() {
    registerFallbackValue(const MapPoint(latitude: 0, longitude: 0));
    registerFallbackValue(
      const GeocodeResult(
        address: 'fallback',
        point: MapPoint(latitude: 0, longitude: 0),
      ),
    );
  });

  setUp(() {
    geocodeRepo = _MockGeocodeRepo();
    cachedGeocodeRepo = _MockCachedGeocodeRepo();
    logger = _MockLogger();
    interactor = GeocodeInteractor(
      geocodeRepo: geocodeRepo,
      cachedGeocodeRepo: cachedGeocodeRepo,
      logger: logger,
    );
  });

  test('returns cached value on cache hit', () async {
    when(
      () => cachedGeocodeRepo.getByPoint(any()),
    ).thenAnswer((_) async => cachedResult);

    final result = await interactor.getGeocode(point);

    expect(result, cachedResult);
    verify(() => cachedGeocodeRepo.getByPoint(any())).called(1);
    verifyNever(() => geocodeRepo.getGeocode(any()));
    verifyNever(() => cachedGeocodeRepo.put(any()));
  });

  test('calls http and stores to cache on cache miss', () async {
    when(
      () => cachedGeocodeRepo.getByPoint(any()),
    ).thenAnswer((_) async => null);
    when(
      () => geocodeRepo.getGeocode(any()),
    ).thenAnswer((_) async => httpResult);
    when(() => cachedGeocodeRepo.put(any())).thenAnswer((_) async {});

    final result = await interactor.getGeocode(point);

    expect(result, httpResult);
    verify(() => cachedGeocodeRepo.getByPoint(any())).called(1);
    verify(() => geocodeRepo.getGeocode(any())).called(1);
    verify(() => cachedGeocodeRepo.put(any())).called(1);
  });

  test('falls back to http when cache read throws', () async {
    when(
      () => cachedGeocodeRepo.getByPoint(any()),
    ).thenThrow(Exception('cache read failed'));
    when(
      () => geocodeRepo.getGeocode(any()),
    ).thenAnswer((_) async => httpResult);
    when(() => cachedGeocodeRepo.put(any())).thenAnswer((_) async {});

    final result = await interactor.getGeocode(point);

    expect(result, httpResult);
    verify(() => cachedGeocodeRepo.getByPoint(any())).called(1);
    verify(() => geocodeRepo.getGeocode(any())).called(1);
    verify(() => cachedGeocodeRepo.put(any())).called(1);
  });
}
