import 'package:flutter/material.dart';

import '../entities/meal_entity.dart';
import '../theme/sumac_theme.dart';

/// Horizontal meal row card (96x96 leading thumbnail + name/description/
/// price + edit/delete actions), used on the cook's My Menu dashboard and
/// anywhere else a cook's own meal list is rendered.
///
/// When [MealEntity.isActive] is false, the card renders the mockup's
/// "out of stock" state: 60% card opacity, a grayscale + dark-overlaid
/// image, and a centered pill badge — edit/delete remain interactive.
///
/// Note (R-25): meal images are specified as always 4:3, but this dense
/// list-row context intentionally uses a fixed 96x96 square thumbnail to
/// match the approved `my_menu_dashboard` mockup — a known, flagged
/// deviation from R-25's full-context photo rule.
class MealCard extends StatelessWidget {
  const MealCard({
    super.key,
    required this.meal,
    required this.outOfStockLabel,
    required this.startingFromLabel,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final MealEntity meal;
  final String outOfStockLabel;
  final String startingFromLabel;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  static const double _thumbnailSize = 96;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isOutOfStock = !meal.isActive;

    return Opacity(
      opacity: isOutOfStock ? 0.6 : 1.0,
      child: Material(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Container(
            padding: const EdgeInsets.all(AppSpace.m),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Thumbnail(
                  imageUrl: meal.imageUrl,
                  isOutOfStock: isOutOfStock,
                  outOfStockLabel: outOfStockLabel,
                ),
                const SizedBox(width: AppSpace.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        meal.name,
                        style: textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpace.xs),
                      Text(
                        meal.description,
                        style: textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpace.xs),
                      Text(
                        meal.hasVariations
                            ? '$startingFromLabel ${meal.displayPrice.toStringAsFixed(0)}'
                            : meal.displayPrice.toStringAsFixed(0),
                        style: AppText.price(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpace.s),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit_outlined),
                      color: scheme.primary,
                      tooltip: 'Edit',
                      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline),
                      color: scheme.error,
                      tooltip: 'Delete',
                      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.imageUrl,
    required this.isOutOfStock,
    required this.outOfStockLabel,
  });

  final String imageUrl;
  final bool isOutOfStock;
  final String outOfStockLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget image = Image.network(
      imageUrl,
      width: MealCard._thumbnailSize,
      height: MealCard._thumbnailSize,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: MealCard._thumbnailSize,
        height: MealCard._thumbnailSize,
        color: scheme.surfaceContainerHighest,
        child: Icon(Icons.restaurant_menu, color: scheme.onSurfaceVariant),
      ),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          width: MealCard._thumbnailSize,
          height: MealCard._thumbnailSize,
          color: scheme.surfaceContainerHighest,
        );
      },
    );

    if (isOutOfStock) {
      image = ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ]),
        child: image,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.image),
      child: SizedBox(
        width: MealCard._thumbnailSize,
        height: MealCard._thumbnailSize,
        child: Stack(
          fit: StackFit.expand,
          children: [
            image,
            if (isOutOfStock) ...[
              Container(color: scheme.surface.withValues(alpha: 0.5)),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpace.s, vertical: AppSpace.xs),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    outOfStockLabel,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: scheme.error, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
