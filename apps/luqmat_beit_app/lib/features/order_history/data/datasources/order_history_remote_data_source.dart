import 'package:core/core.dart';

import 'order_history_data_source.dart';

/// Real implementation, backed by `GET /user/customer/order/history`.
/// No example response is saved in the Postman collection for this
/// endpoint, so the same best-effort JSON shape as
/// `orders_remote_data_source.dart`'s `my-orders` parsing is assumed here —
/// see that file's doc comment for the caveat. `POST
/// /user/customer/order/history/re-add` exists on the backend but has no
/// "reorder" button wired up anywhere in the UI yet, so it isn't called.
class OrderHistoryRemoteDataSource implements OrderHistoryDataSource {
  OrderHistoryRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<OrderEntity>> getOrderHistory() async {
    final response = await _apiClient.get('/user/customer/order/history');
    final ordersJson = (response is Map ? response['orders'] : response) as List? ?? const [];
    return ordersJson.map((o) => _orderFromJson(o as Map)).toList();
  }

  OrderEntity _orderFromJson(Map json) {
    final mealsJson = json['meals'] as List? ?? const [];
    return OrderEntity(
      id: (json['order_id'] ?? json['id']).toString(),
      cookId: json['cook_id']?.toString() ?? '',
      cookName: json['cook_name'] as String? ?? '',
      cookAvatarUrl: json['cook_image'] as String?,
      customerId: json['customer_id']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      status: OrderStatus.values.firstWhere(
        (s) => s.name.toUpperCase() == json['status']?.toString().toUpperCase(),
        orElse: () => OrderStatus.delivered,
      ),
      deliveryAddress: json['delivery_address'] as String? ?? '',
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0,
      discountAmount: (json['discount_amount'] as num?)?.toDouble() ?? 0,
      totalExpectedTimeMinutes: (json['total_expected_time'] as num?)?.toInt() ?? 0,
      mealItems: mealsJson.map((m) {
        final meal = m as Map;
        return OrderMealItemEntity(
          id: (meal['cart_item_id'] ?? meal['meal_id']).toString(),
          mealId: meal['meal_id'].toString(),
          mealName: meal['name'] as String? ?? '',
          mealImageUrl: meal['image'] as String? ?? '',
          sellingOptionLabel: meal['selling_option_label'] as String?,
          priceAtPurchase: (meal['final_price'] as num?)?.toDouble() ??
              (meal['price'] as num?)?.toDouble() ??
              0,
          quantity: (meal['quantity'] as num?)?.toInt() ?? 1,
        );
      }).toList(),
    );
  }
}
