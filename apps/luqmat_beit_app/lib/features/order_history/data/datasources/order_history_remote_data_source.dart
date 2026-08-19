import 'package:core/core.dart';

import 'order_history_data_source.dart';

/// Real implementation, backed by `GET /user/customer/order/history`. Nests
/// items under `order_items: {meals, offers, returned_meals}` and the cook
/// under `cook: {cook_id, name}` — same shape as `my-orders`
/// (`orders_remote_data_source.dart`), confirmed against a populated live
/// response.
class OrderHistoryRemoteDataSource implements OrderHistoryDataSource {
  OrderHistoryRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<OrderEntity>> getOrderHistory() async {
    final response = await _apiClient.get('/user/customer/order/history');
    final ordersJson = (response as Map)['orders'] as List? ?? const [];
    return ordersJson.map((o) => _orderFromJson(o as Map)).toList();
  }

  /// "Re-add to cart (re order)" in the Postman collection —
  /// `POST /user/customer/order/history/re-add`, body `{ "order_id": "1" }`.
  /// A single call re-adds every line item of the order server-side; no
  /// per-item cart calls needed on this side.
  @override
  Future<void> reorder(String orderId) async {
    await _apiClient.post(
      '/user/customer/order/history/re-add',
      data: {'order_id': orderId},
    );
  }

  OrderEntity _orderFromJson(Map json) {
    final items = json['order_items'] as Map? ?? const {};
    final mealsJson = items['meals'] as List? ?? const [];
    final offersJson = items['offers'] as List? ?? const [];
    final returnedJson = items['returned_meals'] as List? ?? const [];
    final cook = json['cook'] as Map? ?? const {};

    return OrderEntity(
      id: json['order_id'].toString(),
      cookId: cook['cook_id']?.toString() ?? '',
      cookName: cook['name'] as String? ?? '',
      customerId: '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      status: OrderStatus.values.firstWhere(
        (s) => s.name.toUpperCase() == json['status']?.toString().toUpperCase(),
        orElse: () => OrderStatus.delivered,
      ),
      deliveryAddress: json['delivery_address'] as String? ?? '',
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0,
      totalExpectedTimeMinutes: (json['total_expected_time'] as num?)?.toInt() ?? 0,
      mealItems: mealsJson.map((m) => _mealItemFromJson(m as Map)).toList(),
      offerItems: offersJson.map((o) => _offerItemFromJson(o as Map)).toList(),
      returnedMealItems: returnedJson.map((r) => _returnedMealItemFromJson(r as Map)).toList(),
    );
  }

  OrderMealItemEntity _mealItemFromJson(Map json) => OrderMealItemEntity(
        id: (json['order_meal_item_id'] ?? json['meal_id']).toString(),
        mealId: json['meal_id'].toString(),
        mealName: json['name'] as String? ?? '',
        mealImageUrl: json['image'] as String? ?? '',
        sellingOptionLabel: _sellingOptionLabel(json['selling_option'] as Map?),
        priceAtPurchase: (json['price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
        note: json['notes'] as String?,
      );

  String? _sellingOptionLabel(Map? option) {
    if (option == null) return null;
    final type = option['type'] as String? ?? '';
    final variation = option['variation'] as String? ?? '';
    final label = [type, variation].where((s) => s.isNotEmpty).join(' - ');
    return label.isEmpty ? null : label;
  }

  OrderOfferItemEntity _offerItemFromJson(Map json) => OrderOfferItemEntity(
        id: (json['order_offer_item_id'] ?? json['offer_id']).toString(),
        offerId: json['offer_id'].toString(),
        offerName: json['name'] as String? ?? '',
        priceAtPurchase: (json['price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      );

  OrderReturnedMealItemEntity _returnedMealItemFromJson(Map json) => OrderReturnedMealItemEntity(
        id: (json['order_returned_meal_item_id'] ?? json['returned_meal_id']).toString(),
        returnedMealId: json['returned_meal_id'].toString(),
        mealName: json['name'] as String? ?? '',
        mealImageUrl: json['image'] as String? ?? '',
        priceAtPurchase: (json['price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      );
}
