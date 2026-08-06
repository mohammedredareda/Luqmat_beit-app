import 'package:core/core.dart';

import 'orders_data_source.dart';

/// Real implementation, backed by `POST /user/customer/order/confirm` and
/// `GET /user/customer/order/my-orders`.
///
/// IMPORTANT: the Postman collection has **no saved example response** for
/// `my-orders` or `confirm` — the JSON shape parsed below is a best-effort
/// guess following the conventions used by every other endpoint in the
/// collection (snake_case, `{cook_id, cook_name, meals:[...]}` grouping like
/// the cart/confirm-request shapes). If the real response differs, a parse
/// mismatch surfaces as a generic failure (via `guard()`'s catch-all) rather
/// than a crash — but this mapping should be the first thing verified
/// against a running backend.
class OrdersRemoteDataSource implements OrdersDataSource {
  OrdersRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<OrderEntity> getOrderById(String orderId) async {
    final orders = await _fetchMyOrders();
    return orders.firstWhere(
      (order) => order.id == orderId,
      orElse: () => throw const NotFoundException('لم يتم العثور على الطلب.'),
    );
  }

  @override
  Future<List<OrderEntity>> getInProgressOrders() async {
    final orders = await _fetchMyOrders();
    return orders
        .where((order) => order.subOrders.any((s) => s.status != OrderStatus.delivered))
        .toList();
  }

  Future<List<OrderEntity>> _fetchMyOrders() async {
    final response = await _apiClient.get('/user/customer/order/my-orders');
    final ordersJson = (response is Map ? response['orders'] : response) as List? ?? const [];
    return ordersJson.map((o) => _orderFromJson(o as Map)).toList();
  }

  OrderEntity _orderFromJson(Map json) {
    final createdAt = DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now();
    return OrderEntity(
      id: (json['order_id'] ?? json['id']).toString(),
      createdAt: createdAt,
      deliveryAddress: json['delivery_address'] as String? ?? '',
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0,
      discountAmount: (json['discount_amount'] as num?)?.toDouble() ?? 0,
      subOrders: [_subOrderFromJson(json)],
    );
  }

  SubOrderEntity _subOrderFromJson(Map json) {
    final mealsJson = json['meals'] as List? ?? const [];
    return SubOrderEntity(
      id: (json['order_id'] ?? json['id']).toString(),
      cookId: json['cook_id']?.toString() ?? '',
      cookName: json['cook_name'] as String? ?? '',
      cookAvatarUrl: json['cook_image'] as String?,
      status: _statusFromJson(json['status']?.toString()),
      items: mealsJson.map((m) => _orderItemFromJson(m as Map)).toList(),
    );
  }

  OrderItemEntity _orderItemFromJson(Map json) => OrderItemEntity(
        id: (json['cart_item_id'] ?? json['meal_id']).toString(),
        mealId: json['meal_id'].toString(),
        mealName: json['name'] as String? ?? '',
        mealImageUrl: json['image'] as String? ?? '',
        sellingOptionLabel: json['selling_option_label'] as String? ?? '',
        priceAtPurchase:
            (json['final_price'] as num?)?.toDouble() ?? (json['price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      );

  OrderStatus _statusFromJson(String? status) {
    return OrderStatus.values.firstWhere(
      (s) => s.name.toUpperCase() == status?.toUpperCase(),
      orElse: () => OrderStatus.pending,
    );
  }

  @override
  Future<String> confirmOrder({
    required String cookId,
    required List<CartItemEntity> items,
    required double deliveryFee,
  }) async {
    final response = await _apiClient.post('/user/customer/order/confirm', data: {
      'cook_id': cookId,
      'meals': items
          .map((item) => {
                'cart_item_id': int.tryParse(item.id) ?? item.id,
                'meal_id': int.tryParse(item.meal.id) ?? item.meal.id,
                'quantity': item.quantity,
                'selling_option_id': int.tryParse(item.sellingOption.id) ?? item.sellingOption.id,
                'price': item.sellingOption.price,
              })
          .toList(),
      'offers': const [],
    });
    if (response is Map) {
      final id = response['order_id'] ?? response['id'];
      if (id != null) return id.toString();
    }
    // No id in the response shape we guessed at — fall back to a
    // client-generated id so checkout still completes; Order Confirmation
    // will fail to look this up via getOrderById until confirmed against a
    // real server response.
    return 'order-${DateTime.now().millisecondsSinceEpoch}';
  }
}
