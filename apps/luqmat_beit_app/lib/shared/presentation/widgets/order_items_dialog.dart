import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../features/orders/presentation/widgets/order_line_item_row.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Shared "what's in this order" popup — order number, cook name, and every
/// line item with its quantity. Opened from both Order History and My
/// Orders card taps, since both just need a read-only summary rather than a
/// dedicated details screen.
Future<void> showOrderItemsDialog(BuildContext context, {required OrderEntity order}) {
  return showDialog<void>(
    context: context,
    builder: (_) => OrderItemsDialog(order: order),
  );
}

class OrderItemsDialog extends StatelessWidget {
  const OrderItemsDialog({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(l10n.orderNumberLabel(order.id)),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline, size: 16, color: scheme.onSurfaceVariant),
                  const SizedBox(width: AppSpace.xs),
                  Text(order.cookName, style: textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: AppSpace.m),
              const Divider(height: 1),
              const SizedBox(height: AppSpace.s),
              for (final item in order.mealItems) OrderLineItemRow.meal(item),
              for (final item in order.offerItems) OrderLineItemRow.offer(item),
              for (final item in order.returnedMealItems)
                OrderLineItemRow.returnedMeal(item),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.okLabel),
        ),
      ],
    );
  }
}
