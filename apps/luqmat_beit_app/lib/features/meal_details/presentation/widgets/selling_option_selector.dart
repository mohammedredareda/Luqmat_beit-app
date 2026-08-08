import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// "خيارات البيع" chip row from the mockup — active chip is solid
/// warm-charcoal, inactive chips are outlined.
class SellingOptionSelector extends StatelessWidget {
  const SellingOptionSelector({
    super.key,
    required this.options,
    required this.selectedOptionId,
    required this.onSelected,
  });

  final List<SellingOptionEntity> options;
  final String selectedOptionId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: AppSpace.s,
      runSpacing: AppSpace.s,
      children: [
        for (final option in options)
          _SellingOptionChip(
            label: '${option.label} — ${option.price.toStringAsFixed(0)}',
            isSelected: option.id == selectedOptionId,
            onTap: () => onSelected(option.id),
            scheme: scheme,
          ),
      ],
    );
  }
}

class _SellingOptionChip extends StatelessWidget {
  const _SellingOptionChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.scheme,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.l,
          vertical: AppSpace.s,
        ),
        decoration: BoxDecoration(
          color: isSelected ? scheme.onSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: isSelected ? scheme.onSurface : scheme.outline,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected ? scheme.surface : scheme.onSurface,
              ),
        ),
      ),
    );
  }
}
