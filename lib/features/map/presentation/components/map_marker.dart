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
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: hidden
                ? const SizedBox.shrink(key: ValueKey('hidden_marker'))
                : BlocBuilder<MapCubit, MapState>(
                    key: const ValueKey('visible_marker'),
                    buildWhen: (previous, current) =>
                        previous.runtimeType != current.runtimeType,
                    builder: (context, state) {
                      final isDragging = state is MapDraggingState;
                      return AnimatedSlide(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        offset: isDragging
                            ? const Offset(0, -0.08)
                            : Offset.zero,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutBack,
                          scale: isDragging ? 1.12 : 1,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 0.9,
                                    end: 1,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: Icon(
                              key: ValueKey<bool>(isDragging),
                              isDragging
                                  ? Icons.place_outlined
                                  : Icons.place,
                              size: 42,
                              color: isDragging
                                  ? Colors.deepOrange
                                  : Colors.red,
                            ),
                          ),
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
