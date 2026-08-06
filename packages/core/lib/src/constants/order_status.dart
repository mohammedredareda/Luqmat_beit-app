/// The unified 5-state order-status vocabulary, shared by both apps
/// (Customer_Cook_Harmonization_Report.md).
enum OrderStatus { pending, accepted, preparing, delivered, rejected }

extension OrderStatusLabel on OrderStatus {
  String get arabicLabel => switch (this) {
        OrderStatus.pending => 'قيد الانتظار',
        OrderStatus.accepted => 'تم القبول',
        OrderStatus.preparing => 'قيد التحضير',
        OrderStatus.delivered => 'تم التوصيل',
        OrderStatus.rejected => 'مرفوض',
      };
}
