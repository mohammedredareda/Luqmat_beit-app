import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// The pill-shaped two-button segmented control used by both the create
/// and edit discount forms to pick [DiscountRestrictionMode] — a custom
/// widget (not Material's `SegmentedButton`) so it matches the mockups'
/// `bg-surface-container p-1 rounded-xl` + selected-segment-gets-a-white-
/// card-with-shadow look exactly. Label text is passed in since the two
/// mockups word it differently ("المدة بالأيام" vs "حسب المدة").
class RestrictionModeSegmentedControl extends StatelessWidget {
  const RestrictionModeSegmentedControl({
    super.key,
    required this.mode,
    required this.durationLabel,
    required this.usageLabel,
    required this.onChanged,
  });

  final DiscountRestrictionMode mode;
  final String durationLabel;
  final String usageLabel;
  final ValueChanged<DiscountRestrictionMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Row(
        children: [
          Expanded(
            child: _Segment(
              label: durationLabel,
              selected: mode == DiscountRestrictionMode.duration,
              onTap: () => onChanged(DiscountRestrictionMode.duration),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _Segment(
              label: usageLabel,
              selected: mode == DiscountRestrictionMode.usage,
              onTap: () => onChanged(DiscountRestrictionMode.usage),
            ),
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
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: selected ? scheme.surface : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      elevation: selected ? 1 : 0,
      shadowColor: scheme.shadow.withValues(alpha: 0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpace.s),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: textTheme.labelLarge?.copyWith(
              color: selected ? scheme.primary : scheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
