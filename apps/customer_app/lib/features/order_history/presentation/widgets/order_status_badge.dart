import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Small pill showing the final status of a past order ("تم التوصيل ✓" /
/// "مرفوض ✕"), matching the order_history mockup's chip styling.
class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDelivered = status == OrderStatus.delivered;
    final background = isDelivered ? scheme.secondaryContainer : scheme.errorContainer;
    final foreground = isDelivered ? scheme.onSecondaryContainer : scheme.onErrorContainer;
    final suffix = isDelivered ? '✓' : '✕';

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpace.s,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '${status.arabicLabel} $suffix',
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: foreground, fontWeight: FontWeight.bold),
      ),
    );
  }
}
