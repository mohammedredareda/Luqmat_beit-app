import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Maps the canonical [OrderStatus] vocabulary onto the *existing*
/// `OrderStatusColors` theme extension (`packages/core`) rather than
/// inventing new tokens or touching a file two other features already
/// depend on. `rejected` and `cancelled` intentionally share one color pair
/// — both are terminal negative states and R-09 doesn't require them to be
/// visually distinguishable, only sourced from one canonical table.
extension OrderStatusColorsX on OrderStatus {
  (Color background, Color foreground) colorsOf(OrderStatusColors table) {
    return switch (this) {
      OrderStatus.pending => (table.pending, table.onPending),
      OrderStatus.preparing => (table.inProgress, table.onInProgress),
      OrderStatus.done => (table.readyToDeliver, table.onReadyToDeliver),
      OrderStatus.rejected => (table.cancelled, table.onCancelled),
      OrderStatus.cancelled => (table.cancelled, table.onCancelled),
    };
  }
}
