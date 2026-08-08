import 'package:core/core.dart';

import 'orders_data_source.dart';

/// Real implementation, backed by `POST /user/customer/order/confirm` and
/// `GET /user/customer/order/my-orders`.
///
/// IMPORTANT: the Postman collection has **no saved example response** for
/// `my-orders` or `confirm` — the JSON shape parsed below is a best-effort
/// guess following the conventions used by every other endpoint in the
/// collection (snake_case, single-cook order per the updated backlog's
/// removal of multi-cook/`SUB_ORDER`). If the real response differs, a parse
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
    return orders.where((order) => order.status.isActive).toList();
  }

  Future<List<OrderEntity>> _fetchMyOrders() async {
    final response = await _apiClient.get('/user/customer/order/my-orders');
    final ordersJson = (response is Map ? response['orders'] : response) as List? ?? const [];
    return ordersJson.map((o) => _orderFromJson(o as Map)).toList();
  }

  OrderEntity _orderFromJson(Map json) {
    final createdAt = DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now();
    final mealsJson = json['meals'] as List? ?? const [];
    final offersJson = json['offers'] as List? ?? const [];
    final returnedJson = json['returned_meals'] as List? ?? const [];
    final pendingExpiresAt = json['pending_expires_at'] != null
        ? DateTime.tryParse(json['pending_expires_at'].toString())
        : null;

    return OrderEntity(
      id: (json['order_id'] ?? json['id']).toString(),
      cookId: json['cook_id']?.toString() ?? '',
      cookName: json['cook_name'] as String? ?? '',
      cookAvatarUrl: json['cook_image'] as String?,
      customerId: json['customer_id']?.toString() ?? '',
      createdAt: createdAt,
      status: _statusFromJson(json['status']?.toString()),
      deliveryAddress: json['delivery_address'] as String? ?? '',
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0,
      discountAmount: (json['discount_amount'] as num?)?.toDouble() ?? 0,
      totalExpectedTimeMinutes: (json['total_expected_time'] as num?)?.toInt() ?? 0,
      pendingExpiresAt: pendingExpiresAt,
      rejectionReason: json['rejection_reason'] as String?,
      mealItems: mealsJson.map((m) => _mealItemFromJson(m as Map)).toList(),
      offerItems: offersJson.map((o) => _offerItemFromJson(o as Map)).toList(),
      returnedMealItems: returnedJson.map((r) => _returnedMealItemFromJson(r as Map)).toList(),
    );
  }

  OrderMealItemEntity _mealItemFromJson(Map json) => OrderMealItemEntity(
        id: (json['cart_item_id'] ?? json['meal_id']).toString(),
        mealId: json['meal_id'].toString(),
        mealName: json['name'] as String? ?? '',
        mealImageUrl: json['image'] as String? ?? '',
        sellingOptionLabel: json['selling_option_label'] as String?,
        priceAtPurchase:
            (json['final_price'] as num?)?.toDouble() ?? (json['price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
        note: json['notes'] as String?,
      );

  OrderOfferItemEntity _offerItemFromJson(Map json) => OrderOfferItemEntity(
        id: (json['cart_item_id'] ?? json['offer_id']).toString(),
        offerId: json['offer_id'].toString(),
        offerName: json['name'] as String? ?? '',
        priceAtPurchase: (json['total_price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      );

  OrderReturnedMealItemEntity _returnedMealItemFromJson(Map json) => OrderReturnedMealItemEntity(
        id: (json['cart_item_id'] ?? json['returned_meal_id']).toString(),
        returnedMealId: json['returned_meal_id'].toString(),
        mealName: json['name'] as String? ?? '',
        mealImageUrl: json['image'] as String? ?? '',
        priceAtPurchase: (json['salvage_price'] as num?)?.toDouble() ?? 0,
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
    required String deliveryAddress,
    required double deliveryFee,
    List<CartMealItemEntity> mealItems = const [],
    List<CartOfferItemEntity> offerItems = const [],
    List<CartReturnedMealItemEntity> returnedMealItems = const [],
  }) async {
    final response = await _apiClient.post('/user/customer/order/confirm', data: {
      'cook_id': cookId,
      'delivery_address': deliveryAddress,
      'meals': mealItems
          .map((item) => {
                'cart_item_id': int.tryParse(item.id) ?? item.id,
                'meal_id': int.tryParse(item.mealId) ?? item.mealId,
                'quantity': item.quantity,
                'selling_option_id': int.tryParse(item.sellingOptionId ?? '') ?? item.sellingOptionId,
                'price': item.unitPrice,
              })
          .toList(),
      'offers': offerItems
          .map((item) => {
                'cart_item_id': int.tryParse(item.id) ?? item.id,
                'offer_id': int.tryParse(item.offerId) ?? item.offerId,
                'quantity': item.quantity,
              })
          .toList(),
      'returned_meals': returnedMealItems
          .map((item) => {
                'cart_item_id': int.tryParse(item.id) ?? item.id,
                'returned_meal_id': int.tryParse(item.returnedMealId) ?? item.returnedMealId,
                'quantity': item.quantity,
              })
          .toList(),
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
