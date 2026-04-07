import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/features/route_builder/presentation/presentation.dart';
import 'package:mrce_test_app/uikit/uikit.dart';

class RouteResultCard extends StatelessWidget {
  const RouteResultCard({required this.bottomOffset, super.key});

  final double bottomOffset;

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isCupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    return Positioned(
      left: 16,
      right: 16,
      bottom: bottomOffset + 8,
      child: SafeArea(
        child: BlocBuilder<RouteBuilderCubit, RouteBuilderState>(
          builder: (context, state) {
            final isVisible =
                state is RouteBuilderLoadedState ||
                state is RouteBuilderLoadingState ||
                state is RouteBuilderFailureState;

            return AnimatedSlide(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              offset: isVisible ? Offset.zero : const Offset(0, 1.5),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 220),
                opacity: isVisible ? 1 : 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(isCupertino ? 14 : 12),
                    border: isCupertino
                        ? Border.all(
                            color: context.colorScheme.outline.withValues(
                              alpha: 0.2,
                            ),
                          )
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isCupertino ? 0.08 : 0.12,
                        ),
                        blurRadius: isCupertino ? 18 : 10,
                        offset: Offset(0, isCupertino ? 8 : 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(isCupertino ? 14 : 12),
                    child: _RouteResultContent(
                      state: state,
                      isCupertino: isCupertino,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RouteResultContent extends StatelessWidget {
  const _RouteResultContent({required this.state, required this.isCupertino});

  final RouteBuilderState state;
  final bool isCupertino;

  @override
  Widget build(BuildContext context) {
    final originAddress = switch (state) {
      RouteBuilderLoadingState(:final origin) => origin.address,
      RouteBuilderLoadedState(:final origin) => origin.address,
      RouteBuilderFailureState(:final origin) => origin.address,
      _ => null,
    };
    final destinationAddress = switch (state) {
      RouteBuilderLoadingState(:final destination) => destination.address,
      RouteBuilderLoadedState(:final destination) => destination.address,
      RouteBuilderFailureState(:final destination) => destination.address,
      _ => null,
    };

    if (originAddress == null || destinationAddress == null) {
      return const SizedBox.shrink();
    }

    final textScheme = context.textScheme;
    final primaryColor = context.colorScheme.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddressRow(
          address: originAddress,
          letter: 'A',
          color: Colors.green.shade600,
        ),
        const SizedBox(height: 6),
        AddressRow(
          address: destinationAddress,
          letter: 'B',
          color: Colors.red.shade600,
        ),
        const SizedBox(height: 10),
        if (state is RouteBuilderLoadingState) ...[
          const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        ] else if (state case RouteBuilderLoadedState(:final routeInfo)) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.straighten_rounded, size: 16, color: primaryColor),
              const SizedBox(width: 4),
              Text(
                routeInfo.distanceText,
                style: textScheme.titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 20),
              Icon(Icons.schedule_rounded, size: 16, color: primaryColor),
              const SizedBox(width: 4),
              Text(
                routeInfo.durationText,
                style: textScheme.titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: AppPlatformStyleButton(
              label: 'Закрыть',
              isCupertino: isCupertino,
              variant: AppPlatformButtonVariant.secondary,
              cupertinoVerticalPadding: 10,
              onPressed: () => context.read<RouteBuilderCubit>().cancel(),
            ),
          ),
        ] else if (state is RouteBuilderFailureState) ...[
          Text(
            'Не удалось построить маршрут',
            style: textScheme.bodyMedium.copyWith(
              color: context.colorScheme.error,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: AppPlatformStyleButton(
              label: 'Закрыть',
              isCupertino: isCupertino,
              variant: AppPlatformButtonVariant.secondary,
              cupertinoVerticalPadding: 10,
              onPressed: () => context.read<RouteBuilderCubit>().cancel(),
            ),
          ),
        ],
      ],
    );
  }
}
