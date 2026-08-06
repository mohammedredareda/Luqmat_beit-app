import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Small pill badge for the unified 5-state order-status vocabulary,
/// reused by My Orders (U09) and anywhere else an order status is shown.
class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (background, foreground, dot) = switch (status) {
      OrderStatus.pending => (
          scheme.surfaceContainerHighest,
          scheme.onSurfaceVariant,
          scheme.onSurfaceVariant,
        ),
      OrderStatus.accepted => (
          scheme.secondaryContainer,
          scheme.onSecondaryContainer,
          scheme.onSecondaryContainer,
        ),
      OrderStatus.preparing => (
          scheme.tertiaryContainer,
          scheme.onTertiaryContainer,
          scheme.tertiary,
        ),
      OrderStatus.delivered => (
          scheme.secondaryContainer,
          scheme.onSecondaryContainer,
          scheme.secondary,
        ),
      OrderStatus.rejected => (
          scheme.errorContainer,
          scheme.onErrorContainer,
          scheme.error,
        ),
    };

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpace.m,
        vertical: AppSpace.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpace.xs),
          Text(
            status.arabicLabel,
            style: TextStyle(
              color: foreground,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
