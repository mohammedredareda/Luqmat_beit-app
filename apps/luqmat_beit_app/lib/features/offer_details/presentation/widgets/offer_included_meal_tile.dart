import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// One row in the offer details screen's "يتضمن هذا العرض" (this offer
/// includes) list — mirrors the mockup's meal rows. [OfferBundleMealEntity]
/// carries no per-item quantity today, so unlike the mockup's "×N" corner
/// badge, this only shows what the entity actually has: image, name, and
/// [OfferBundleMealEntity.variationLabel] as the subtitle.
class OfferIncludedMealTile extends StatelessWidget {
  const OfferIncludedMealTile({super.key, required this.meal});

  final OfferBundleMealEntity meal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.s),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.image),
            child: SizedBox(
              width: 64,
              height: 64,
              child: meal.imageUrl.isEmpty
                  ? Container(color: scheme.surfaceContainerHighest)
                  : Image.network(
                      meal.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: scheme.surfaceContainerHighest),
                    ),
            ),
          ),
          const SizedBox(width: AppSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge,
                ),
                if (meal.variationLabel.isNotEmpty) ...[
                  const SizedBox(height: AppSpace.xs),
                  Text(
                    meal.variationLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
