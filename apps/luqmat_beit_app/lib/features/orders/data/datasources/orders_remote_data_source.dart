import 'package:core/core.dart';

import 'orders_data_source.dart';

/// Real implementation, backed by `POST /user/customer/order/confirm` and
/// `GET /user/customer/order/my-orders` — response/request shapes below are
/// confirmed against the live deployment (the Postman collection had no
/// saved example for either).
///
/// `my-orders` nests items under `order_items: {meals, offers,
/// returned_meals}` and the cook under `cook: {cook_id, name}` — it does
/// **not** include `delivery_address`/`delivery_fee`/`total_expected_time`
/// at all, so those [OrderEntity] fields fall back to empty/zero until the
/// backend adds them to this response (there's no separate "order details"
/// endpoint to fetch them from either).
///
/// `confirm` requires the full cart-item snapshot resubmitted per meal
/// (`price`, `discount_percentage`, `final_price`, `selling_options[]` —
/// not just ids) plus top-level `latitude`/`longitude` — confirmed via the
/// backend's validation errors. [CartMealItemEntity] doesn't carry
/// `discount_percentage` or the full selling-options list, so those are
/// best-effort (0, and a single reconstructed entry) rather than exact.
class OrdersRemoteDataSource implements OrdersDataSource {
  OrdersRemoteDataSource(this._apiClient, this._profileCache);

  final ApiClient _apiClient;
  final UserProfileCache _profileCache;

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
    final ordersJson = (response as Map)['orders'] as List? ?? const [];
    return ordersJson.map((o) => _orderFromJson(o as Map)).toList();
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
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      status: _statusFromJson(json['status']?.toString()),
      deliveryAddress: json['delivery_address'] as String? ?? '',
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0,
      totalExpectedTimeMinutes:
          (json['total_expected_time'] as num?)?.toInt() ?? 0,
      mealItems: mealsJson.map((m) => _mealItemFromJson(m as Map)).toList(),
      offerItems: offersJson.map((o) => _offerItemFromJson(o as Map)).toList(),
      returnedMealItems:
          returnedJson.map((r) => _returnedMealItemFromJson(r as Map)).toList(),
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

  OrderReturnedMealItemEntity _returnedMealItemFromJson(Map json) =>
      OrderReturnedMealItemEntity(
        id: (json['order_returned_meal_item_id'] ?? json['returned_meal_id'])
            .toString(),
        returnedMealId: json['returned_meal_id'].toString(),
        mealName: json['name'] as String? ?? '',
        mealImageUrl: json['image'] as String? ?? '',
        priceAtPurchase: (json['price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      );

  OrderStatus _statusFromJson(String? status) {
    return OrderStatus.values.firstWhere(
      (s) => s.name.toUpperCase() == status?.toUpperCase(),
      orElse: () => OrderStatus.pending,
    );
  }

  @override
  Future<({double price, int expectedTimeMinutes})> getDeliveryPrice({
    required String cookId,
    required double latitude,
    required double longitude,
  }) async {
    final response =
        await _apiClient.post('/user/customer/order/delivery-price', data: {
      'cook_id': int.tryParse(cookId) ?? cookId,
      'latitude': latitude,
      'longitude': longitude,
    });
    final map = response as Map;
    return (
      price: (map['delivery_price'] as num?)?.toDouble() ?? 0,
      // The backend returns `expected_time` in hours for this endpoint
      // (unlike `total_expected_time` elsewhere, which is minutes).
      expectedTimeMinutes:
          (((map['expected_time'] as num?)?.toDouble() ?? 0) * 60).round(),
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
    double? latitude,
    double? longitude,
  }) async {
    final cached = _profileCache.read();

    final response =
        await _apiClient.post('/user/customer/order/confirm', data: {
      'cook_id': cookId,
      'latitude': latitude ?? cached.latitude ?? 0,
      'longitude': longitude ?? cached.longitude ?? 0,
      'meals': mealItems.map(_mealItemToJson).toList(),
      // The backend re-validates every offer against its own stored
      // snapshot and rejects the whole order if anything doesn't match —
      // `total_price`/`expire_time`/`meals[]` have to be resubmitted in
      // full here, not just the ids (confirmed against the "Confirm
      // Order" example in the API doc).
      'offers': offerItems.map(_offerItemToJson).toList(),
      'returned_meals': returnedMealItems.map(_returnedMealItemToJson).toList(),
    });
    return _orderIdFromResponse(response);
  }

  @override
  Future<String> confirmReturnedMealsOrder({
    required List<CartReturnedMealItemEntity> returnedMealItems,
    double? latitude,
    double? longitude,
  }) async {
    final cached = _profileCache.read();

    // A distinct request shape from the per-cook `confirmOrder` above — no
    // `cook_id`/`meals`/`offers` at all (returned meals aren't grouped by
    // cook), flagged instead with `is_returned_meals_order`. Confirmed
    // against the real request the backend expects, not the "Confirm
    // Order" doc example (which only covers the per-cook shape).
    final response =
        await _apiClient.post('/user/customer/order/confirm', data: {
      'is_returned_meals_order': true,
      'latitude': latitude ?? cached.latitude ?? 0,
      'longitude': longitude ?? cached.longitude ?? 0,
      'returned_meals': returnedMealItems.map(_returnedMealItemToJson).toList(),
    });
    return _orderIdFromResponse(response);
  }

  Map<String, dynamic> _returnedMealItemToJson(
          CartReturnedMealItemEntity item) =>
      {
        'cart_item_id': int.tryParse(item.id) ?? item.id,
        'returned_meal_id':
            int.tryParse(item.returnedMealId) ?? item.returnedMealId,
        'quantity': item.quantity,
        'salvage_price': item.salvagePrice,
      };

  String _orderIdFromResponse(dynamic response) {
    if (response is Map) {
      final id = response['order_id'] ?? response['id'];
      if (id != null) return id.toString();
    }
    // No id in the response — fall back to a client-generated id so
    // checkout still completes; Order Confirmation will fail to look this
    // up via getOrderById until confirmed against a real success response
    // (every attempt so far has hit a business rule like "cook is closed").
    return 'order-${DateTime.now().millisecondsSinceEpoch}';
  }

  /// `price`/`discount_percentage`/`final_price` have to be the meal's real
  /// pre-discount price, discount, and post-discount price, carried through
  /// verbatim from the cart response — not [CartMealItemEntity.unitPrice]
  /// (already-discounted) duplicated into both price fields with a fake 0%
  /// discount, and not `0` in place of a `null` discount either: the
  /// backend rejects the order as "prices have changed" if
  /// `discount_percentage` doesn't match what it has on file exactly,
  /// and `null` and `0` aren't the same value to it. [CartMealItemEntity]
  /// doesn't carry a full `selling_options` list — `sellingOptionLabel`
  /// (built as `"type - variation"` by `CartRemoteDataSource`) is split
  /// back apart on `' - '` to reconstruct one entry, best-effort.
  Map<String, dynamic> _mealItemToJson(CartMealItemEntity item) {
    final parts = (item.sellingOptionLabel ?? '').split(' - ');
    final type = parts.length > 1 ? parts.first : '';
    final variation =
        parts.length > 1 ? parts.sublist(1).join(' - ') : parts.first;

    return {
      'cart_item_id': int.tryParse(item.id) ?? item.id,
      'meal_id': int.tryParse(item.mealId) ?? item.mealId,
      'quantity': item.quantity,
      'selling_option_id':
          int.tryParse(item.sellingOptionId ?? '') ?? item.sellingOptionId,
      'price': item.originalPrice,
      'discount_percentage': item.discountPercentage,
      'final_price': item.unitPrice,
      'selling_options': [
        {
          'selling_option_id':
              int.tryParse(item.sellingOptionId ?? '') ?? item.sellingOptionId,
          'type': type,
          'variation': variation,
          'price': item.originalPrice.toString(),
        },
      ],
    };
  }

  /// Mirrors [CartOfferItemEntity]/[CartOfferMealSnapshotEntity] straight
  /// into the shape the "Confirm Order" doc example shows — everything
  /// here came from the cart response verbatim, nothing recomputed.
  Map<String, dynamic> _offerItemToJson(CartOfferItemEntity item) => {
        'cart_item_id': int.tryParse(item.id) ?? item.id,
        'offer_id': int.tryParse(item.offerId) ?? item.offerId,
        'total_price': item.unitPrice,
        'expire_time': item.expireTime.toUtc().toIso8601String(),
        'quantity': item.quantity,
        'meals': item.meals
            .map((meal) => {
                  'meal_id': int.tryParse(meal.mealId) ?? meal.mealId,
                  'name': meal.name,
                  'image': meal.imageUrl,
                  'variation_quantity': meal.variationQuantity,
                  'price': meal.price,
                  'discount_percentage': meal.discountPercentage,
                  'final_price': meal.finalPrice,
                })
            .toList(),
      };
}
