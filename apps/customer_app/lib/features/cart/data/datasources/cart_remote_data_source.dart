import 'package:core/core.dart';

import 'cart_data_source.dart';

/// Real implementation, backed by the `Customer > Cart` folder of
/// `AI_INSTRUCTIONS/Loqmet Beit.postman_collection.json`.
///
/// The backend's `GET /user/customer/cart` groups items by cook and also
/// returns `offers`/`returned_meals` arrays alongside `meals` — all three
/// are now surfaced, matching the updated backlog's `CART_MEAL_ITEM` /
/// `CART_OFFER_ITEM` / `CART_RETURNED_MEAL_ITEM` split.
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

    final mealItems = <CartMealItemEntity>[];
    final offerItems = <CartOfferItemEntity>[];
    final returnedMealItems = <CartReturnedMealItemEntity>[];
    String? cookId;

    for (final cookEntry in cooksJson) {
      final cook = cookEntry as Map;
      cookId ??= cook['cook_id']?.toString();
      final mealsJson = cook['meals'] as List? ?? const [];
      final offersJson = cook['offers'] as List? ?? const [];
      final returnedJson = cook['returned_meals'] as List? ?? const [];

      mealItems.addAll(mealsJson.map((m) => _mealItemFromJson(m as Map)));
      offerItems.addAll(offersJson.map((o) => _offerItemFromJson(o as Map)));
      returnedMealItems
          .addAll(returnedJson.map((r) => _returnedMealItemFromJson(r as Map)));
    }

    _mealSnapshot = mealItems;
    return CartEntity(
      customerId: json['customer_id']?.toString() ?? '',
      cookId: cookId,
      mealItems: mealItems,
      offerItems: offerItems,
      returnedMealItems: returnedMealItems,
    );
  }

  CartMealItemEntity _mealItemFromJson(Map json) => CartMealItemEntity(
        id: json['cart_item_id'].toString(),
        mealId: json['meal_id'].toString(),
        mealName: json['name'] as String? ?? '',
        mealImageUrl: json['image'] as String? ?? '',
        sellingOptionId: json['selling_option_id']?.toString(),
        sellingOptionLabel: json['selling_option_label'] as String?,
        unitPrice:
            (json['final_price'] as num?)?.toDouble() ?? (json['price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
        note: json['notes'] as String?,
      );

  CartOfferItemEntity _offerItemFromJson(Map json) => CartOfferItemEntity(
        id: json['cart_item_id'].toString(),
        offerId: json['offer_id'].toString(),
        offerName: json['name'] as String? ?? '',
        offerImageUrl: json['image'] as String?,
        unitPrice: (json['total_price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      );

  CartReturnedMealItemEntity _returnedMealItemFromJson(Map json) => CartReturnedMealItemEntity(
        id: json['cart_item_id'].toString(),
        returnedMealId: json['returned_meal_id'].toString(),
        mealName: json['name'] as String? ?? '',
        mealImageUrl: json['image'] as String? ?? '',
        salvagePrice: (json['salvage_price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      );

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
      'selling_option_id':
          int.tryParse(current?.sellingOptionId ?? '') ?? current?.sellingOptionId,
      'notes': current?.note ?? '',
    });
  }

  @override
  Future<void> removeItem(String cartItemId) async {
    await _apiClient.delete('/user/customer/cart/meals/$cartItemId');
  }

  @override
  Future<void> updateSellingOption(String cartItemId, String sellingOptionId) async {
    final current = _find(cartItemId);
    await _apiClient.put('/user/customer/cart/meals/$cartItemId', data: {
      'quantity': current?.quantity ?? 1,
      'selling_option_id': int.tryParse(sellingOptionId) ?? sellingOptionId,
      'notes': current?.note ?? '',
    });
  }
}
