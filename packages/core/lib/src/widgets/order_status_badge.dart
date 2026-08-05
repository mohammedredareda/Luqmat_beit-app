import 'package:flutter/material.dart';

import '../theme/sumac_theme.dart';

/// Generic order-status pill chip — label/background/foreground in, chip
/// out. Deliberately unaware of `OrderStatus`/`OrderStatusColors` so `core`
/// never depends on either; callers resolve the color pair (R-09: one
/// canonical table) and pass them in.
class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.s, vertical: AppSpace.xs),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: foreground, fontWeight: FontWeight.w600),
      ),
    );
  }
}
