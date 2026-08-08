import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// One "name ×qty ... price" line, reused by the bill/breakdown sections on
/// Order Confirmation (U06) and Invoice (U08) — takes plain values rather
/// than a specific item-entity type since an order's line items come from
/// three different typed lists (meal/offer/returned-meal) that all share
/// this same display shape.
class OrderLineItemRow extends StatelessWidget {
  const OrderLineItemRow({
    super.key,
    required this.name,
    required this.quantity,
    required this.subtotal,
  });

  OrderLineItemRow.meal(OrderMealItemEntity item, {super.key})
      : name = item.mealName,
        quantity = item.quantity,
        subtotal = item.subtotal;

  OrderLineItemRow.offer(OrderOfferItemEntity item, {super.key})
      : name = item.offerName,
        quantity = item.quantity,
        subtotal = item.subtotal;

  OrderLineItemRow.returnedMeal(OrderReturnedMealItemEntity item, {super.key})
      : name = item.mealName,
        quantity = item.quantity,
        subtotal = item.subtotal;

  final String name;
  final int quantity;
  final double subtotal;

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
              '$name ×$quantity',
              style: textTheme.bodyLarge,
            ),
          ),
          Text(
            subtotal.toStringAsFixed(0),
            style: textTheme.bodyLarge
                ?.copyWith(color: scheme.onSurface, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
