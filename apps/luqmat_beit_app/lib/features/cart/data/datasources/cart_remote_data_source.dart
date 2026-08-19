import 'package:core/core.dart';

import 'cart_data_source.dart';

/// Real implementation, backed by the `Customer > Cart` folder of
/// `AI_INSTRUCTIONS/Loqmet Beit.postman_collection.json`, response shape
/// confirmed against the live deployment.
///
/// The backend's `GET /user/customer/cart` groups `meals`/`offers` per cook
/// under `cooks[]`, but `returned_meals` is a **top-level sibling of
/// `cooks`**, not nested per cook (confirmed live — the Postman collection
/// doesn't show this). Each meal item carries its own `selling_options[]`
/// list (`{selling_option_id, type, variation, price}`) rather than a flat
/// label — `sellingOptionLabel` is built by matching `selling_option_id`
/// against that list.
///
/// `PUT .../cart/meals/:id` requires the full `{quantity, selling_option_id,
/// notes}` triple on every call, but [CartRepository.updateQuantity] and
/// `.updateSellingOption` each only receive one changed field — the last
/// fetched snapshot is kept here so the other two fields can be filled in.
class CartRemoteDataSource implements CartDataSource {
  CartRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  List<CartMealItemEntity> _mealSnapshot = const [];

  @override
  Future<CartEntity> getCart() async {
    final json = await _apiClient.get('/user/customer/cart') as Map;
    final cooksJson = json['cooks'] as List? ?? const [];
    final returnedJson = json['returned_meals'] as List? ?? const [];

    final groups = cooksJson.map((c) => _cookGroupFromJson(c as Map)).toList();

    _mealSnapshot = groups.expand((g) => g.mealItems).toList();
    return CartEntity(
      customerId: json['customer_id']?.toString() ?? '',
      cookGroups: groups,
      returnedMealItems:
          returnedJson.map((r) => _returnedMealItemFromJson(r as Map)).toList(),
    );
  }

  CartCookGroupEntity _cookGroupFromJson(Map json) {
    final mealsJson = json['meals'] as List? ?? const [];
    final offersJson = json['offers'] as List? ?? const [];
    return CartCookGroupEntity(
      cookId: json['cook_id'].toString(),
      cookName: json['cook_name'] as String? ?? '',
      mealItems: mealsJson.map((m) => _mealItemFromJson(m as Map)).toList(),
      offerItems: offersJson.map((o) => _offerItemFromJson(o as Map)).toList(),
    );
  }

  CartMealItemEntity _mealItemFromJson(Map json) {
    final sellingOptionsJson = json['selling_options'] as List? ?? const [];
    final sellingOptionId = json['selling_option_id']?.toString();

    final availableOptions = sellingOptionsJson.map((so) {
      final option = so as Map;
      final type = option['type'] as String? ?? '';
      final variation = option['variation'] as String? ?? '';
      return SellingOptionEntity(
        id: option['selling_option_id'].toString(),
        label: [type, variation].where((s) => s.isNotEmpty).join(' - '),
        price: double.tryParse(option['price']?.toString() ?? '') ?? 0,
      );
    }).toList();

    String? label;
    for (final option in availableOptions) {
      if (option.id == sellingOptionId) {
        label = option.label;
        break;
      }
    }

    return CartMealItemEntity(
      id: json['cart_item_id'].toString(),
      mealId: json['meal_id'].toString(),
      mealName: json['name'] as String? ?? '',
      mealImageUrl: json['image'] as String? ?? '',
      sellingOptionId: sellingOptionId,
      sellingOptionLabel: (label == null || label.isEmpty) ? null : label,
      unitPrice: (json['final_price'] as num?)?.toDouble() ??
          (json['price'] as num?)?.toDouble() ??
          0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      note: json['notes'] as String?,
      originalPrice: (json['price'] as num?)?.toDouble(),
      discountPercentage: (json['discount_percentage'] as num?)?.toDouble(),
      availableSellingOptions: availableOptions,
    );
  }

  CartOfferItemEntity _offerItemFromJson(Map json) {
    final mealsJson = json['meals'] as List? ?? const [];
    return CartOfferItemEntity(
      id: json['cart_item_id'].toString(),
      offerId: json['offer_id'].toString(),
      offerName: json['name'] as String? ?? '',
      offerImageUrl: json['image'] as String?,
      // `total_price` comes back as a JSON string here (same as the
      // customer offers-list endpoint), unlike meal items' numeric
      // `price`/`final_price` — parse leniently rather than casting.
      unitPrice: double.tryParse(json['total_price']?.toString() ?? '') ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      // `expire_time`/`meals` aren't shown anywhere in the cart UI — kept
      // only so `POST /order/confirm` can resubmit this offer's exact
      // snapshot (the backend rejects the order otherwise).
      expireTime: DateTime.tryParse(json['expire_time']?.toString() ?? '') ??
          DateTime.now(),
      meals:
          mealsJson.map((m) => _offerMealSnapshotFromJson(m as Map)).toList(),
    );
  }

  CartOfferMealSnapshotEntity _offerMealSnapshotFromJson(Map json) =>
      CartOfferMealSnapshotEntity(
        mealId: json['meal_id'].toString(),
        name: json['name'] as String? ?? '',
        imageUrl: json['image'] as String? ?? '',
        variationQuantity: json['variation_quantity'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0,
        discountPercentage: (json['discount_percentage'] as num?)?.toDouble(),
        finalPrice: (json['final_price'] as num?)?.toDouble() ?? 0,
      );

  CartReturnedMealItemEntity _returnedMealItemFromJson(Map json) {
    final meal = json['meal'] as Map? ?? const {};
    return CartReturnedMealItemEntity(
      id: json['cart_item_id'].toString(),
      returnedMealId: json['returned_meal_id'].toString(),
      // Name/image are nested under `meal`, not top-level, confirmed
      // against the live `GET /user/customer/cart` response.
      mealName: meal['name'] as String? ?? '',
      mealImageUrl: meal['image'] as String? ?? '',
      salvagePrice: (json['salvage_price'] as num?)?.toDouble() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );
  }

  @override
  Future<void> addItem({
    required MealEntity meal,
    required SellingOptionEntity sellingOption,
    required int quantity,
    String? note,
  }) async {
    await _apiClient.post('/user/customer/cart/meals', data: {
      'meal_id': int.tryParse(meal.id) ?? meal.id,
      'selling_option_id': int.tryParse(sellingOption.id) ?? sellingOption.id,
      'count': quantity,
      'notes': note ?? '',
    });
  }

  CartMealItemEntity? _find(String cartItemId) {
    try {
      return _mealSnapshot.firstWhere((item) => item.id == cartItemId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateQuantity(String cartItemId, int quantity) async {
    final current = _find(cartItemId);
    await _apiClient.put('/user/customer/cart/meals/$cartItemId', data: {
      'quantity': quantity,
      'selling_option_id': int.tryParse(current?.sellingOptionId ?? '') ??
          current?.sellingOptionId,
      'notes': current?.note ?? '',
    });
  }

  @override
  Future<void> removeItem(String cartItemId) async {
    await _apiClient.delete('/user/customer/cart/meals/$cartItemId');
  }

  @override
  Future<void> updateSellingOption(
      String cartItemId, String sellingOptionId) async {
    final current = _find(cartItemId);
    await _apiClient.put('/user/customer/cart/meals/$cartItemId', data: {
      'quantity': current?.quantity ?? 1,
      'selling_option_id': int.tryParse(sellingOptionId) ?? sellingOptionId,
      'notes': current?.note ?? '',
    });
  }

  @override
  Future<void> updateNote(String cartItemId, String note) async {
    final current = _find(cartItemId);
    await _apiClient.put('/user/customer/cart/meals/$cartItemId', data: {
      'quantity': current?.quantity ?? 1,
      'selling_option_id': int.tryParse(current?.sellingOptionId ?? '') ??
          current?.sellingOptionId,
      'notes': note,
    });
  }

  @override
  Future<void> addReturnedMeal(
      {required String returnedMealId, required int count}) async {
    await _apiClient.post('/user/customer/cart/returned-meals', data: {
      'returned_meal_id': int.tryParse(returnedMealId) ?? returnedMealId,
      'count': count,
    });
  }

  @override
  Future<void> addOffer({required String offerId, required int count}) async {
    await _apiClient.post('/user/customer/cart/offers', data: {
      'offer_id': int.tryParse(offerId) ?? offerId,
      'count': count,
    });
  }
}
