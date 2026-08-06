import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Local pill filter chip for the chef's menu tag filters. Not core's
/// `CategoryChip` (that's Home's `CategoryEntity`-typed widget) — this one
/// filters by plain meal tag strings, scoped to a single chef's menu.
class MenuFilterChip extends StatelessWidget {
  const MenuFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.l,
          vertical: AppSpace.s,
        ),
        decoration: BoxDecoration(
          color: isSelected ? scheme.primary : scheme.surface,
          borderRadius: BorderRadius.circular(999),
          border: isSelected ? null : Border.all(color: scheme.outline),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? scheme.onPrimary : scheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
