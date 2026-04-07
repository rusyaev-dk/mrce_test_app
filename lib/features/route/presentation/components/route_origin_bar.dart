import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrce_test_app/features/route/presentation/presentation.dart';

class RouteOriginBar extends StatelessWidget {
  const RouteOriginBar({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isCupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    return BlocBuilder<RouteBuilderCubit, RouteBuilderState>(
      buildWhen: (previous, current) =>
          (previous is RouteBuilderSelectingDestinationState) !=
          (current is RouteBuilderSelectingDestinationState),
      builder: (context, state) {
        final isVisible = state is RouteBuilderSelectingDestinationState;

        return AnimatedSlide(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          offset: isVisible ? Offset.zero : const Offset(0, -1.5),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isVisible ? 1 : 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(isCupertino ? 14 : 12),
                border: isCupertino
                    ? Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.2),
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
                padding: EdgeInsets.symmetric(
                  horizontal: isCupertino ? 14 : 12,
                  vertical: isCupertino ? 10 : 8,
                ),
                child: Row(
                  children: [
                    RouteLetterMarker(
                      letter: 'A',
                      color: Colors.green.shade600,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        isVisible ? state.origin.address : '',
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _CancelButton(isCupertino: isCupertino),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.isCupertino});

  final bool isCupertino;

  @override
  Widget build(BuildContext context) {
    if (isCupertino) {
      return CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: const Size(28, 28),
        onPressed: () => context.read<RouteBuilderCubit>().cancel(),
        child: const Text('Отмена'),
      );
    }

    return TextButton(
      onPressed: () => context.read<RouteBuilderCubit>().cancel(),
      style: TextButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: const Text('Отмена'),
    );
  }
}
