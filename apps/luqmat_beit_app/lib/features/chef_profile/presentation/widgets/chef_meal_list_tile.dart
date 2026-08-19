import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// Row-style meal card for the chef's menu list, per the chef-profile
/// mockup — a horizontal card (image start-aligned in RTL, 4:3 per R-25)
/// rather than core's grid `MealCard`, to match the approved layout.
class ChefMealListTile extends StatelessWidget {
  const ChefMealListTile({super.key, required this.meal, required this.onTap});

  final MealEntity meal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.all(AppSpace.m),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.sheet),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.card),
              child: SizedBox(
                width: 120,
                child: AspectRatio(
                  // R-25: meal images are always 4:3.
                  aspectRatio: 4 / 3,
                  child: Image.network(meal.imageUrl, fit: BoxFit.cover),
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
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppSpace.xs),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: AppColors.honey),
                      const SizedBox(width: AppSpace.xs),
                      Text(
                        '${meal.rating.toStringAsFixed(1)} (${meal.ratingCount}+)',
                        style: textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpace.s),
                  Text(
                    '${meal.startingPrice.toStringAsFixed(0)} ${AppLocalizations.of(context)!.currencySuffix}',
                    style: textTheme.titleMedium?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
