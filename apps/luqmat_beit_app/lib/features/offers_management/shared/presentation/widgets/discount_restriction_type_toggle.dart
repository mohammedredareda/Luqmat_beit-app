import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/discount_restriction_type.dart';

/// The "تحديد نوع القيد"/"نوع الصلاحية" segmented control shared by Create
/// and Edit Discount (per their respective mockups) — a discount is bound
/// by exactly one of duration or usage-count, never both, so only one
/// side is ever selected. Callers supply the two labels since Create and
/// Edit use slightly different wording for the same choice.
class DiscountRestrictionTypeToggle extends StatelessWidget {
  const DiscountRestrictionTypeToggle({
    super.key,
    required this.value,
    required this.durationLabel,
    required this.usageLabel,
    required this.onChanged,
  });

  final DiscountRestrictionType value;
  final String durationLabel;
  final String usageLabel;
  final ValueChanged<DiscountRestrictionType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpace.xs),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.badge),
      ),
      child: Row(
        children: [
          _Segment(
            label: durationLabel,
            selected: value == DiscountRestrictionType.duration,
            onTap: () => onChanged(DiscountRestrictionType.duration),
          ),
          const SizedBox(width: AppSpace.xs),
          _Segment(
            label: usageLabel,
            selected: value == DiscountRestrictionType.usageCount,
            onTap: () => onChanged(DiscountRestrictionType.usageCount),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Material(
        color: selected ? scheme.surface : Colors.transparent,
        elevation: selected ? 1 : 0,
        borderRadius: BorderRadius.circular(AppRadius.badge),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.badge),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpace.s),
            child: Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: selected ? scheme.primary : scheme.onSurfaceVariant,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
