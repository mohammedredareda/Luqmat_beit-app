import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// One meal/selling-option row showing its price struck through next to
/// the price after a discount percentage is applied. Shared by create and
/// edit discount so a meal with multiple selling options (CK-07) always
/// gets one row per option, never a single collapsed price.
class DiscountPriceAfterRow extends StatelessWidget {
  const DiscountPriceAfterRow({
    super.key,
    required this.label,
    required this.oldPrice,
    required this.percentage,
  });

  final String label;
  final double oldPrice;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final newPrice = oldPrice * (1 - percentage / 100);

    return Container(
      padding: const EdgeInsets.all(AppSpace.m),
      margin: const EdgeInsets.only(bottom: AppSpace.s),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border.all(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppRadius.input),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textTheme.bodyLarge),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(oldPrice.toStringAsFixed(2), style: AppText.priceOld(context)),
              const SizedBox(width: AppSpace.s),
              Text(
                newPrice.toStringAsFixed(2),
                style: textTheme.titleMedium?.copyWith(color: scheme.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
