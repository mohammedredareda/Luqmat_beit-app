import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../shared/presentation/order_line_items.dart';
import '../../../shared/presentation/time_ago.dart';

/// One order row on the My Orders list (`my_orders` mockup): square icon
/// tile, order number, elapsed-time-since-placed, status badge, an
/// item-summary preview (with overflow), total price, and Details/Accept
/// actions.
class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.orderNumberLabel,
    required this.moreItemsLabel,
    required this.currencySuffix,
    required this.detailsLabel,
    required this.acceptLabel,
    this.onTap,
    this.onAccept,
  });

  final OrderEntity order;
  final String orderNumberLabel;
  final String Function(int count) moreItemsLabel;
  final String currencySuffix;
  final String detailsLabel;
  final String acceptLabel;
  final VoidCallback? onTap;
  final VoidCallback? onAccept;

  static const double _previewLineCount = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final lineItems = flattenOrderLineItems(order);
    final preview = lineItems.take(_previewLineCount.toInt()).toList();
    final overflowCount = lineItems.length - preview.length;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.all(AppSpace.m),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.sumacContainer,
                      borderRadius: BorderRadius.circular(AppRadius.badge),
                    ),
                    child: const Icon(Icons.receipt_long, color: AppColors.onSumacContainer),
                  ),
                  const SizedBox(width: AppSpace.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(orderNumberLabel, style: textTheme.titleMedium),
                        const SizedBox(height: AppSpace.xs),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.schedule, size: 14, color: scheme.onSurfaceVariant),
                            const SizedBox(width: 4),
                            Text(
                              formatTimeAgo(l10n, order.createdAt),
                              style: textTheme.bodySmall
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpace.s),
                  OrderStatusBadge(status: order.status),
                ],
              ),
              const SizedBox(height: AppSpace.m),
              for (final item in preview) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('•  ', style: TextStyle(color: scheme.outline)),
                    Expanded(
                      child: Text(
                        '${item.quantity}x ${item.name}',
                        style: textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.xs),
              ],
              if (overflowCount > 0)
                Text(moreItemsLabel(overflowCount), style: textTheme.bodySmall),
              const SizedBox(height: AppSpace.m),
              Row(
                children: [
                  Text(
                    '${order.grandTotal.toStringAsFixed(0)} $currencySuffix',
                    style: AppText.price(context),
                  ),
                  const Spacer(),
                  OutlinedButton(onPressed: onTap, child: Text(detailsLabel)),
                  if (order.status == OrderStatus.pending) ...[
                    const SizedBox(width: AppSpace.s),
                    ElevatedButton(onPressed: onAccept, child: Text(acceptLabel)),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
