/// The canonical order-status vocabulary, confirmed identical in both the
/// Cook and Customer module backlogs (Rev. 7+): pending → preparing → done →
/// delivering → delivered, with cancelled/rejected/returned as terminal
/// off-ramps. There is no separate "accepted" state — Accept goes straight
/// to [preparing].
enum OrderStatus {
  pending,
  preparing,
  done,
  delivering,
  delivered,
  cancelled,
  rejected,
  returned,
}

extension OrderStatusLabel on OrderStatus {
  String get arabicLabel => switch (this) {
        OrderStatus.pending => 'قيد الانتظار',
        OrderStatus.preparing => 'قيد التحضير',
        OrderStatus.done => 'جاهز للتوصيل',
        OrderStatus.delivering => 'قيد التوصيل',
        OrderStatus.delivered => 'تم التوصيل',
        OrderStatus.cancelled => 'ملغي',
        OrderStatus.rejected => 'مرفوض',
        OrderStatus.returned => 'مرتجع',
      };

  /// Whether the order is still in a live, non-terminal state.
  bool get isActive => switch (this) {
        OrderStatus.pending ||
        OrderStatus.preparing ||
        OrderStatus.done ||
        OrderStatus.delivering =>
          true,
        OrderStatus.delivered ||
        OrderStatus.cancelled ||
        OrderStatus.rejected ||
        OrderStatus.returned =>
          false,
      };
}
