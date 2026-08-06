import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// The fixed bottom section: subtotal/delivery/total breakdown plus the
/// single full-width primary action for the screen (R-01) — proceeding
/// to checkout.
class CartSummaryFooter extends StatelessWidget {
  const CartSummaryFooter({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.onCheckout,
  });

  final double subtotal;
  final double deliveryFee;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final total = subtotal + deliveryFee;

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpace.l,
        vertical: AppSpace.l,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: BorderDirectional(top: BorderSide(color: scheme.outline.withValues(alpha: 0.3))),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryLine(label: 'المجموع الفرعي', value: subtotal, textTheme: textTheme, scheme: scheme),
            const SizedBox(height: AppSpace.xs),
            _SummaryLine(label: 'رسوم التوصيل', value: deliveryFee, textTheme: textTheme, scheme: scheme),
            const SizedBox(height: AppSpace.s),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('الإجمالي', style: textTheme.titleLarge),
                Text(
                  '${total.toStringAsFixed(2)} AED',
                  style: textTheme.titleLarge?.copyWith(color: scheme.primary),
                ),
              ],
            ),
            const SizedBox(height: AppSpace.l),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.primary,
                  foregroundColor: scheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.card),
                  ),
                ),
                child: const Text('تأكيد الكل'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({
    required this.label,
    required this.value,
    required this.textTheme,
    required this.scheme,
  });

  final String label;
  final double value;
  final TextTheme textTheme;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
        Text('${value.toStringAsFixed(2)} AED', style: textTheme.bodyMedium),
      ],
    );
  }
}
