import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/map/presentation/blocs/geocode_bloc/geocode_bloc.dart';
import 'package:mrce_test_app/features/map/presentation/blocs/map_cubit/map_cubit.dart';
import 'package:mrce_test_app/features/map/presentation/components/components.dart';
import 'package:mrce_test_app/features/route/presentation/presentation.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _routePolylineId = MapObjectId('route_polyline');
  static const _originMarkerId = MapObjectId('origin_marker');
  static const _destinationMarkerId = MapObjectId('destination_marker');

  YandexMapController? _mapController;
  Uint8List? _markerABytes;
  Uint8List? _markerBBytes;

  @override
  void initState() {
    super.initState();
    _loadMarkerBitmaps();
  }

  Future<void> _loadMarkerBitmaps() async {
    final a = await RouteMarkerBitmaps.markerA;
    final b = await RouteMarkerBitmaps.markerB;
    if (mounted) {
      setState(() {
        _markerABytes = a;
        _markerBBytes = b;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final platform = Theme.of(context).platform;
    final navBarHeight =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS
        ? 60
        : 80;
    final bottomOffset = bottomInset + navBarHeight - 35;

    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (previous, current) =>
          (previous is MapIdleState &&
              current is MapIdleState &&
              previous.center != current.center) ||
          (previous is! MapDraggingState && current is MapDraggingState),
      listener: (context, state) {
        if (state is MapDraggingState) {
          context.read<GeocodeBloc>().add(const ClearGeocodeEvent());
          return;
        }

        if (state is! MapIdleState || _mapController == null) return;
        _moveCameraTo(state.center);
      },
      builder: (context, mapState) {
        if (mapState.isOffline) {
          return const OfflineWarning();
        }

        final isDragging = mapState is MapDraggingState;
        return BlocBuilder<RouteBuilderCubit, RouteBuilderState>(
          builder: (context, routeState) {
            final mapObjects = <MapObject>[];

            if (routeState is RouteBuilderLoadedState) {
              mapObjects.add(
                PolylineMapObject(
                  mapId: _routePolylineId,
                  polyline: Polyline(
                    points: routeState.routeInfo.polylinePoints
                        .map(
                          (p) => Point(
                            latitude: p.latitude,
                            longitude: p.longitude,
                          ),
                        )
                        .toList(),
                  ),
                  strokeColor: Theme.of(context).colorScheme.primary,
                  strokeWidth: 4,
                  outlineColor: Colors.white,
                  outlineWidth: 1,
                ),
              );
            }

            final originPoint = routeState.originPoint;
            final destinationPoint = routeState.destinationPoint;

            if (originPoint != null && _markerABytes != null) {
              mapObjects.add(
                PlacemarkMapObject(
                  mapId: _originMarkerId,
                  point: _toYandexPoint(originPoint),
                  opacity: 1,
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image: BitmapDescriptor.fromBytes(_markerABytes!),
                      scale: 0.55,
                    ),
                  ),
                  zIndex: 10,
                ),
              );
            }

            if (destinationPoint != null && _markerBBytes != null) {
              mapObjects.add(
                PlacemarkMapObject(
                  mapId: _destinationMarkerId,
                  point: _toYandexPoint(destinationPoint),
                  opacity: 1,
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image: BitmapDescriptor.fromBytes(_markerBBytes!),
                      scale: 0.55,
                    ),
                  ),
                  zIndex: 10,
                ),
              );
            }

            return Stack(
              children: [
                YandexMap(
                  mapObjects: mapObjects,
                  onMapCreated: (controller) async {
                    _mapController = controller;
                    await _moveCameraTo(mapState.center, withAnimation: false);
                  },
                  onCameraPositionChanged: (cameraPosition, _, finished) {
                    final center = _toMapPoint(cameraPosition.target);
                    final cubit = context.read<MapCubit>();
                    if (finished) {
                      cubit.onCameraIdle(center);
                      context.read<GeocodeBloc>().add(
                        RequestGeocodeEvent(point: center),
                      );
                      return;
                    }
                    cubit.onCameraMove(center);
                  },
                ),
                IgnorePointer(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    color: isDragging
                        ? Colors.black.withValues(alpha: 0.08)
                        : Colors.transparent,
                  ),
                ),
                const CenterMarker(),
                Positioned(
                  top: MediaQuery.paddingOf(context).top + 8,
                  left: 16,
                  right: 16,
                  child: const RouteOriginBar(),
                ),
                GeocodeResultCard(bottomOffset: bottomOffset),
                RouteResultCard(bottomOffset: bottomOffset),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _moveCameraTo(
    MapPoint point, {
    bool withAnimation = true,
  }) async {
    final controller = _mapController;
    if (controller == null) return;

    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _toYandexPoint(point)),
      ),
      animation: withAnimation ? const MapAnimation(duration: 0.25) : null,
    );
  }

  Point _toYandexPoint(MapPoint point) =>
      Point(latitude: point.latitude, longitude: point.longitude);

  MapPoint _toMapPoint(Point point) =>
      MapPoint(latitude: point.latitude, longitude: point.longitude);
}
