import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// One pill in the horizontal filter-chip row (`code.html` "Filter Chips").
/// Selected state fills with the primary/sumac color and shows a check
/// mark; unselected chips are outlined. [trailingDropdown] renders the
/// `arrow_drop_down` glyph used by the "السعر"/"الصنف" chips, which open a
/// picker rather than toggling in place.
class SearchFilterChip extends StatelessWidget {
  const SearchFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.trailingDropdown = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool trailingDropdown;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: selected ? scheme.primary : scheme.surface,
      shape: StadiumBorder(
        side: BorderSide(color: selected ? Colors.transparent : scheme.outline),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpace.l,
            vertical: AppSpace.s,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (selected && !trailingDropdown) ...[
                const SizedBox(width: AppSpace.xs),
                Icon(Icons.check, size: 16, color: scheme.onPrimary),
              ],
              if (trailingDropdown) ...[
                const SizedBox(width: AppSpace.xs),
                Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
