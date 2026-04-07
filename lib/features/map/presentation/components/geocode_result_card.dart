import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/map/presentation/presentation.dart';
import 'package:mrce_test_app/features/route_builder/presentation/presentation.dart';
import 'package:mrce_test_app/features/saved_addresses/presentation/presentation.dart';
import 'package:mrce_test_app/uikit/uikit.dart';

class GeocodeResultCard extends StatefulWidget {
  const GeocodeResultCard({required this.bottomOffset, super.key});

  final double bottomOffset;

  @override
  State<GeocodeResultCard> createState() => _GeocodeResultCardState();
}

class _GeocodeResultCardState extends State<GeocodeResultCard> {
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isCupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
    final maxCardHeight = MediaQuery.sizeOf(context).height * 0.25;

    return Positioned(
      left: 16,
      right: 16,
      bottom: widget.bottomOffset + 8,
      child: SafeArea(
        child: BlocBuilder<RouteBuilderCubit, RouteBuilderState>(
          builder: (context, routeState) {
            final routeActive = routeState is! RouteBuilderInactiveState;
            final routeResultVisible =
                routeState is RouteBuilderLoadedState ||
                routeState is RouteBuilderLoadingState ||
                routeState is RouteBuilderFailureState;

            return BlocBuilder<MapCubit, MapState>(
              buildWhen: (previous, current) =>
                  previous.runtimeType != current.runtimeType,
              builder: (context, mapState) {
                return BlocBuilder<GeocodeBloc, GeocodeState>(
                  builder: (context, geocodeState) {
                    final isVisible =
                        geocodeState is! GeocodeInitialState &&
                        mapState is! MapDraggingState &&
                        !routeResultVisible;

                    return AnimatedSlide(
                      duration: const Duration(milliseconds: 260),
                      curve: Curves.easeOutCubic,
                      offset: isVisible ? Offset.zero : const Offset(0, 1.2),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isVisible ? 1 : 0,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: maxCardHeight),
                          child: GeocodeResultCardContent(
                            isCupertino: isCupertino,
                            geocodeState: geocodeState,
                            routeActive: routeActive,
                            onSavePressed: () => _openSaveAddressDialog(
                              context,
                              geocodeState as GeocodeLoadedState,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _openSaveAddressDialog(
    BuildContext context,
    GeocodeLoadedState geocodeState,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return BlocProvider(
          create: (context) =>
              AddressValidatorCubit(logger: context.read<ILogger>()),
          child: SaveAddressDialogContent(
            geocodeState: geocodeState,
            dialogContext: dialogContext,
          ),
        );
      },
    );
  }
}

class GeocodeResultCardContent extends StatelessWidget {
  const GeocodeResultCardContent({
    required this.isCupertino,
    required this.geocodeState,
    required this.routeActive,
    required this.onSavePressed,
    super.key,
  });

  final bool isCupertino;
  final GeocodeState geocodeState;
  final bool routeActive;
  final VoidCallback onSavePressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(isCupertino ? 14 : 12),
        border: isCupertino
            ? Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isCupertino ? 0.08 : 0.12),
            blurRadius: isCupertino ? 18 : 10,
            offset: Offset(0, isCupertino ? 8 : 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isCupertino ? 14 : 12,
          vertical: isCupertino ? 12 : 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: _AddressStateText(state: geocodeState),
                  ),
                ),
              ],
            ),
            if (geocodeState is GeocodeLoadedState)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: _ActionButtons(
                  isCupertino: isCupertino,
                  geocodeState: geocodeState as GeocodeLoadedState,
                  isSelectingDestination: routeActive,
                  onSavePressed: onSavePressed,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.isCupertino,
    required this.geocodeState,
    required this.isSelectingDestination,
    required this.onSavePressed,
  });

  final bool isCupertino;
  final GeocodeLoadedState geocodeState;
  final bool isSelectingDestination;
  final VoidCallback onSavePressed;

  @override
  Widget build(BuildContext context) {
    if (isSelectingDestination) {
      return AppPlatformStyleButton(
        label: 'Построить маршрут',
        isCupertino: isCupertino,
        variant: AppPlatformButtonVariant.primary,
        icon: Icons.directions,
        cupertinoVerticalPadding: 10,
        onPressed: () =>
            context.read<RouteBuilderCubit>().buildRoute(geocodeState.result),
      );
    }
    return Row(
      children: [
        Expanded(
          child: AppPlatformStyleButton(
            label: 'Сохранить',
            isCupertino: isCupertino,
            variant: AppPlatformButtonVariant.secondary,
            icon: Icons.bookmark_add_outlined,
            onPressed: onSavePressed,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AppPlatformStyleButton(
            label: 'Маршрут',
            isCupertino: isCupertino,
            variant: AppPlatformButtonVariant.primary,
            icon: Icons.directions,
            onPressed: () => context
                .read<RouteBuilderCubit>()
                .startRouteBuilding(geocodeState.result),
          ),
        ),
      ],
    );
  }
}

class _AddressStateText extends StatelessWidget {
  const _AddressStateText({required this.state});

  final GeocodeState state;

  @override
  Widget build(BuildContext context) {
    final textScheme = context.textScheme;
    return switch (state) {
      GeocodeLoadingState() => Row(
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Определяем адрес...',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: textScheme.bodyMedium,
            ),
          ),
        ],
      ),
      GeocodeLoadedState(:final result) => Text(
        result.address,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: textScheme.bodyMedium.copyWith(fontWeight: FontWeight.w500),
      ),
      GeocodeFailureState(:final failure) => Text(
        _errorMessage(failure),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: textScheme.bodyMedium.copyWith(color: context.colorScheme.error),
      ),
      _ => Text(
        'Переместите карту для выбора точки',
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: textScheme.bodyMedium,
      ),
    };
  }

  String _errorMessage(Object? failure) {
    return switch (failure) {
      ApiValidationException() => 'Некорректный запрос геокодера',
      ApiNotFoundException() => 'Адрес не найден',
      ApiServerException() => 'Сервис геокодирования временно недоступен',
      ApiTimeoutException() =>
        'Не удалось получить адрес: превышено время ожидания',
      _ => 'Не удалось определить адрес',
    };
  }
}
