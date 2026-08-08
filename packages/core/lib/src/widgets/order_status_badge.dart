import 'package:flutter/material.dart';

import '../constants/order_status.dart';
import '../theme/app_theme.dart';

/// Shared status pill so both apps can never disagree on how an
/// [OrderStatus] reads visually. Maps the 8-value vocabulary onto the 6
/// colors in [OrderStatusColors] — `rejected`/`returned` reuse `cancelled`'s
/// palette since both are negative terminal outcomes.
class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OrderStatusColors>()!;
    final (background, foreground) = switch (status) {
      OrderStatus.pending => (colors.pending, colors.onPending),
      OrderStatus.preparing => (colors.inProgress, colors.onInProgress),
      OrderStatus.done => (colors.readyToDeliver, colors.onReadyToDeliver),
      OrderStatus.delivering => (colors.delivering, colors.onDelivering),
      OrderStatus.delivered => (colors.delivered, colors.onDelivered),
      OrderStatus.cancelled ||
      OrderStatus.rejected ||
      OrderStatus.returned =>
        (colors.cancelled, colors.onCancelled),
    };

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpace.s,
        vertical: AppSpace.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        status.arabicLabel,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
