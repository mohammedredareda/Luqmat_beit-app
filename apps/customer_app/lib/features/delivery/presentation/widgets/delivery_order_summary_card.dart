import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// "تفاصيل العشاء" card — line items + delivery fee + grand total.
class DeliveryOrderSummaryCard extends StatelessWidget {
  const DeliveryOrderSummaryCard({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final items = order.subOrders.expand((sub) => sub.items).toList();

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.m),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: [
          BoxShadow(
            color: AppColors.inkLight.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpace.s),
            decoration: BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(color: scheme.outlineVariant),
              ),
            ),
            width: double.infinity,
            child: Text('تفاصيل العشاء', style: textTheme.headlineSmall),
          ),
          const SizedBox(height: AppSpace.m),
          for (final item in items) ...[
            _SummaryRow(
              label: '${item.quantity}x ${item.mealName}',
              value: '${item.subtotal.toStringAsFixed(2)} JOD',
            ),
            const SizedBox(height: AppSpace.s),
          ],
          _SummaryRow(
            label: 'رسوم التوصيل',
            value: '${order.deliveryFee.toStringAsFixed(2)} JOD',
            valueColor: scheme.secondary,
          ),
          const SizedBox(height: AppSpace.m),
          Container(
            padding: const EdgeInsetsDirectional.only(top: AppSpace.m),
            decoration: BoxDecoration(
              border: BorderDirectional(
                top: BorderSide(color: scheme.outlineVariant, width: 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('الإجمالي', style: textTheme.titleLarge),
                Text(
                  '${order.grandTotal.toStringAsFixed(2)} JOD',
                  style: textTheme.headlineMedium
                      ?.copyWith(color: scheme.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            color: valueColor ?? scheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
