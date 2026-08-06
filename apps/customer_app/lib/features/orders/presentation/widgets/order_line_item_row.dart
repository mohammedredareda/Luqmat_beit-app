import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// One "meal ×qty ... price" line, reused by the bill/breakdown sections on
/// Order Confirmation (U06) and Invoice (U08).
class OrderLineItemRow extends StatelessWidget {
  const OrderLineItemRow({super.key, required this.item});

  final OrderItemEntity item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpace.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${item.mealName} ×${item.quantity}',
              style: textTheme.bodyLarge,
            ),
          ),
          Text(
            item.subtotal.toStringAsFixed(0),
            style: textTheme.bodyLarge
                ?.copyWith(color: scheme.onSurface, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
