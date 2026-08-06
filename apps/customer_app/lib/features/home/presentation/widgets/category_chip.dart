import 'package:flutter/material.dart';

import '../../domain/entities/home_feed_entity.dart';

const _iconByName = {
  'restaurant': Icons.restaurant,
  'bakery_dining': Icons.bakery_dining,
  'icecream': Icons.icecream,
  'tapas': Icons.tapas,
};

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final CategoryEntity category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? scheme.primaryContainer : scheme.surface,
          borderRadius: BorderRadius.circular(999),
          border: isSelected ? null : Border.all(color: scheme.outline.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _iconByName[category.iconName] ?? Icons.restaurant,
              size: 20,
              color: isSelected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              category.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
