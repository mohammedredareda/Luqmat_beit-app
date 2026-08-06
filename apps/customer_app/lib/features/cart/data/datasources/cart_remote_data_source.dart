import 'package:core/core.dart';

import 'cart_data_source.dart';

/// Real implementation, backed by the `Customer > Cart` folder of
/// `AI_INSTRUCTIONS/Loqmet Beit.postman_collection.json`.
///
/// The backend's `GET /user/customer/cart` groups items by cook and also
/// returns `offers`/`returned_meals` lines that don't fit [CartItemEntity]
/// (which models a single meal + selling option) — only the `meals` lines
/// are surfaced here.
///
/// `PUT .../cart/meals/:id` requires the full `{quantity, selling_option_id,
/// notes}` triple on every call, but [CartRepository.updateQuantity] and
/// `.updateSellingOption` each only receive one changed field — the last
/// fetched snapshot is kept here so the other two fields can be filled in.
class CartRemoteDataSource implements CartDataSource {
  CartRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  List<CartItemEntity> _snapshot = const [];

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    final json = await _apiClient.get('/user/customer/cart') as Map;
    final cooksJson = json['cooks'] as List? ?? const [];
    final items = <CartItemEntity>[];

    for (final cookEntry in cooksJson) {
      final cook = cookEntry as Map;
      final cookId = cook['cook_id']?.toString() ?? '';
      final cookName = cook['cook_name'] as String? ?? '';
      final mealsJson = cook['meals'] as List? ?? const [];
      for (final mealEntry in mealsJson) {
        items.add(_cartItemFromJson(mealEntry as Map, cookId, cookName));
      }
    }

    _snapshot = items;
    return items;
  }

  CartItemEntity _cartItemFromJson(Map json, String cookId, String cookName) {
    final sellingOptionsJson = json['selling_options'] as List? ?? const [];
    final sellingOptions = sellingOptionsJson.map((so) {
      final option = so as Map;
      final type = option['type'] as String? ?? '';
      final variation = option['variation'] as String? ?? '';
      return SellingOptionEntity(
        id: option['selling_option_id'].toString(),
        label: [type, variation].where((s) => s.isNotEmpty).join(' - '),
        price: double.tryParse(option['price']?.toString() ?? '') ?? 0,
      );
    }).toList();

    final currentOptionId = json['selling_option_id'].toString();
    final currentOption = sellingOptions.firstWhere(
      (o) => o.id == currentOptionId,
      orElse: () => SellingOptionEntity(
        id: currentOptionId,
        label: '',
        price: (json['final_price'] as num?)?.toDouble() ?? (json['price'] as num?)?.toDouble() ?? 0,
      ),
    );

    return CartItemEntity(
      id: json['cart_item_id'].toString(),
      meal: MealEntity(
        id: json['meal_id'].toString(),
        cookId: cookId,
        cookName: cookName,
        name: json['name'] as String? ?? '',
        description: '',
        imageUrl: json['image'] as String? ?? '',
        sellingOptions: sellingOptions.isEmpty ? [currentOption] : sellingOptions,
      ),
      sellingOption: currentOption,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      note: json['notes'] as String?,
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

  CartItemEntity? _find(String cartItemId) {
    try {
      return _snapshot.firstWhere((item) => item.id == cartItemId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateQuantity(String cartItemId, int quantity) async {
    final current = _find(cartItemId);
    await _apiClient.put('/user/customer/cart/meals/$cartItemId', data: {
      'quantity': quantity,
      'selling_option_id': int.tryParse(current?.sellingOption.id ?? '') ?? current?.sellingOption.id,
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
