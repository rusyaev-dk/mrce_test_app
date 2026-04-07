import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrce_test_app/features/map/presentation/presentation.dart';
import 'package:mrce_test_app/features/route_builder/presentation/presentation.dart';

class CenterMarker extends StatelessWidget {
  const CenterMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<RouteBuilderCubit, RouteBuilderState>(
        buildWhen: (previous, current) =>
            _shouldHide(previous) != _shouldHide(current),
        builder: (context, routeState) {
          final hidden = _shouldHide(routeState);
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: hidden ? 0 : 1,
            child: BlocBuilder<MapCubit, MapState>(
              buildWhen: (previous, current) =>
                  previous.runtimeType != current.runtimeType,
              builder: (context, state) {
                final isDragging = state is MapDraggingState;
                return AnimatedScale(
                  duration: const Duration(milliseconds: 160),
                  scale: isDragging ? 1.1 : 1,
                  child: Icon(
                    isDragging ? Icons.place_outlined : Icons.place,
                    size: 42,
                    color: isDragging ? Colors.deepOrange : Colors.red,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  bool _shouldHide(RouteBuilderState state) =>
      state is RouteBuilderLoadingState ||
      state is RouteBuilderLoadedState ||
      state is RouteBuilderFailureState;
}
