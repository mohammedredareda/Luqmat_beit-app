import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// The cook-facing menu-row card — core's [MealCard] is deliberately
/// display-only (R-24: no edit/delete affordances belong on a shared,
/// customer-visible card), so this local widget adds the edit/delete
/// actions the My Menu dashboard needs. Row layout matches
/// `view_menu_skeleton.dart`'s `_MealRowSkeleton` shape (R-29).
class CookMealCard extends StatelessWidget {
  const CookMealCard({
    super.key,
    required this.meal,
    required this.isActive,
    required this.outOfStockLabel,
    required this.startingFromLabel,
    required this.onEdit,
    required this.onDelete,
  });

  final MealEntity meal;
  final bool isActive;
  final String outOfStockLabel;
  final String startingFromLabel;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.m),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.image),
            child: Opacity(
              opacity: isActive ? 1 : 0.5,
              child: SizedBox(
                width: 96,
                height: 96,
                child: Image.network(meal.imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(width: AppSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  meal.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpace.xs),
                Text(
                  meal.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpace.xs),
                Text(
                  isActive
                      ? '$startingFromLabel ${meal.startingPrice.toStringAsFixed(0)}'
                      : outOfStockLabel,
                  style: textTheme.bodySmall?.copyWith(
                    color: isActive ? scheme.primary : scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.s),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'edit',
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete_outline, color: scheme.error),
            tooltip: 'delete',
          ),
        ],
      ),
    );
  }
}
