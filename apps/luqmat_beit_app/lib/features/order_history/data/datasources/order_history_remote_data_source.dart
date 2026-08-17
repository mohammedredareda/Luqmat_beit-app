import 'package:core/core.dart';

import 'order_history_data_source.dart';

/// Real implementation, backed by `GET /user/customer/order/history`. The
/// live response was empty (`{"orders":[],"page":1,...}`) when confirmed,
/// so items are parsed with the same `order_items: {meals, offers,
/// returned_meals}` nesting confirmed for `my-orders`
/// (`orders_remote_data_source.dart`) rather than an actual populated
/// example — that file's doc comment covers the same caveats (no
/// `cook_id`/`delivery_address`/etc. on the order itself).
class OrderHistoryRemoteDataSource implements OrderHistoryDataSource {
  OrderHistoryRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<OrderEntity>> getOrderHistory() async {
    final response = await _apiClient.get('/user/customer/order/history');
    final ordersJson = (response as Map)['orders'] as List? ?? const [];
    return ordersJson.map((o) => _orderFromJson(o as Map)).toList();
  }

  OrderEntity _orderFromJson(Map json) {
    final items = json['order_items'] as Map? ?? const {};
    final mealsJson = items['meals'] as List? ?? const [];
    final offersJson = items['offers'] as List? ?? const [];
    final returnedJson = items['returned_meals'] as List? ?? const [];

    return OrderEntity(
      id: json['order_id'].toString(),
      cookId: json['cook_id']?.toString() ?? '',
      cookName: json['cook_name'] as String? ?? '',
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
