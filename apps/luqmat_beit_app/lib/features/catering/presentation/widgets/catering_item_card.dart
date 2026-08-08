import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// A single line item in the catering review list — meal image, name,
/// short subtitle, unit price, and a quantity pill (mirrors the
/// catering_review_s12 mockup's high-quantity item cards, e.g. "x15").
class CateringItemCard extends StatelessWidget {
  const CateringItemCard({super.key, required this.item});

  final CartMealItemEntity item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.m),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.3)),
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
              width: 80,
              height: 80,
              child: Image.network(
                item.mealImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: scheme.surfaceContainerHighest,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.mealName,
                  style: textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpace.xs),
                Text(
                  item.sellingOptionLabel ?? '',
                  style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.s),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${item.unitPrice.toStringAsFixed(0)} د.أ',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppSpace.xs),
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpace.s,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  'x${item.quantity}',
                  style: textTheme.labelLarge?.copyWith(color: scheme.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
