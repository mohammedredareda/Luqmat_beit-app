import 'package:flutter/material.dart';

import '../entities/meal_entity.dart';
import '../theme/app_theme.dart';

/// Shared meal card — renders the greyed-out / "غير متاح للطلب" badge state
/// so both apps can never disagree on whether a meal reads as orderable.
/// R-24: tapping this card only opens meal details — "Add to Cart" itself
/// must never be reachable from here.
class MealCard extends StatelessWidget {
  const MealCard({
    super.key,
    required this.meal,
    required this.isActive,
    required this.currencySuffix,
    required this.onTap,
  });

  final MealEntity meal;
  final bool isActive;
  final String currencySuffix;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isActive ? 1 : 0.5,
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: scheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    // R-25: meal images are always 4:3.
                    aspectRatio: 4 / 3,
                    child: Image.network(meal.imageUrl, fit: BoxFit.cover),
                  ),
                  if (!isActive)
                    PositionedDirectional(
                      top: AppSpace.s,
                      end: AppSpace.s,
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpace.s,
                          vertical: AppSpace.xs,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.inverseSurface,
                          borderRadius: BorderRadius.circular(AppRadius.badge),
                        ),
                        child: Text(
                          'غير متاح للطلب',
                          style: TextStyle(
                            color: scheme.onInverseSurface,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(AppSpace.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpace.xs),
                    Text(
                      meal.cookName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: AppSpace.s),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${meal.startingPrice.toStringAsFixed(0)} $currencySuffix',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: scheme.primary),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: AppColors.honey),
                            const SizedBox(width: AppSpace.xs),
                            Text(meal.rating.toStringAsFixed(1)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
