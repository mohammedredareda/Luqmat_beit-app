import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Row-style "من نصيبك" (returned/salvage meal) result in the Search list —
/// tapping opens Meal Details in its returned-meal mode (see
/// `MealDetailsPage.returnedMeal`), same flow as Home's equivalent slider.
class SearchReturnedMealResultTile extends StatelessWidget {
  const SearchReturnedMealResultTile({
    super.key,
    required this.item,
    required this.currencySuffix,
    required this.onTap,
  });

  final ReturnedMealEntity item;
  final String currencySuffix;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final discountPercentage = item.originalPrice > 0
        ? (1 - item.salvagePrice / item.originalPrice) * 100
        : 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.all(AppSpace.m),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.image),
              child: SizedBox(
                width: 72,
                height: 72,
                child: Image.network(item.imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: AppSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.mealName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium),
                  const SizedBox(height: AppSpace.xs),
                  Row(
                    children: [
                      Text(
                        '${item.salvagePrice.toStringAsFixed(0)} $currencySuffix',
                        style: textTheme.titleSmall?.copyWith(
                            color: scheme.primary, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: AppSpace.s),
                      Text(
                        '${item.originalPrice.toStringAsFixed(0)} $currencySuffix',
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpace.s,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '${discountPercentage.toStringAsFixed(0)}%-',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
