import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/features/saved_addresses/domain/domain.dart';

class SavedAddressCard extends StatelessWidget {
  const SavedAddressCard({
    required this.address,
    this.onTap,
    this.onDeletePressed,
    super.key,
  });

  final Address address;
  final VoidCallback? onTap;
  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isCupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    final titleStyle = context.textScheme.titleSmall.copyWith(
      fontWeight: FontWeight.w600,
    );
    final subtitleStyle = context.textScheme.bodyMedium;
    final coordinatesStyle = context.textScheme.bodySmall.copyWith(
      color: context.colorScheme.onSurface.withValues(alpha: 0.72),
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isCupertino
              ? CupertinoColors.systemBackground.resolveFrom(context)
              : context.colorScheme.surface,
          borderRadius: BorderRadius.circular(isCupertino ? 14 : 12),
          border: isCupertino
              ? Border.all(
                  color: CupertinoColors.separator
                      .resolveFrom(context)
                      .withValues(alpha: 0.5),
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isCupertino ? 0.06 : 0.1),
              blurRadius: isCupertino ? 14 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isCupertino
                    ? CupertinoIcons.location_solid
                    : Icons.location_on_rounded,
                size: 18,
                color: isCupertino ? CupertinoColors.activeBlue : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(address.name, style: titleStyle, maxLines: 1),
                    const SizedBox(height: 4),
                    Text(
                      address.address,
                      style: subtitleStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${address.point.latitude.toStringAsFixed(6)}, '
                      '${address.point.longitude.toStringAsFixed(6)}',
                      style: coordinatesStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!isCupertino)
                IconButton(
                  onPressed: onDeletePressed,
                  tooltip: 'Удалить',
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.delete_outline_rounded, size: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
