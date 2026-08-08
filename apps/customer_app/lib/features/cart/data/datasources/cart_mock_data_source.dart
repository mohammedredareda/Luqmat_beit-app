import 'package:core/core.dart';

import '../../../../shared/mock/sample_catalog.dart';
import 'cart_data_source.dart';

/// Stands in for `cart_remote_data_source.dart` until a backend exists.
/// Holds the cart in an in-memory mutable state for the session so
/// quantity/remove/selling-option actions actually mutate what the screen
/// shows, without needing persistence yet.
class CartMockDataSource implements CartDataSource {
  static final _meal1 = SampleCatalog.mealById('meal-1');
  static final _meal2 = SampleCatalog.mealById('meal-2');
  static final _meal3 = SampleCatalog.mealById('meal-3');

  final List<CartMealItemEntity> _mealItems = [
    CartMealItemEntity(
      id: 'cart-1',
      mealId: _meal1.id,
      mealName: _meal1.name,
      mealImageUrl: _meal1.imageUrl,
      sellingOptionId: _meal1.sellingOptions.first.id,
      sellingOptionLabel: _meal1.sellingOptions.first.label,
      unitPrice: _meal1.sellingOptions.first.price,
      quantity: 2,
    ),
    CartMealItemEntity(
      id: 'cart-2',
      mealId: _meal2.id,
      mealName: _meal2.name,
      mealImageUrl: _meal2.imageUrl,
      sellingOptionId: _meal2.sellingOptions[1].id,
      sellingOptionLabel: _meal2.sellingOptions[1].label,
      unitPrice: _meal2.sellingOptions[1].price,
      quantity: 1,
      note: 'بدون بصل',
    ),
    CartMealItemEntity(
      id: 'cart-3',
      mealId: _meal3.id,
      mealName: _meal3.name,
      mealImageUrl: _meal3.imageUrl,
      sellingOptionId: _meal3.sellingOptions.first.id,
      sellingOptionLabel: _meal3.sellingOptions.first.label,
      unitPrice: _meal3.sellingOptions.first.price,
      quantity: 1,
    ),
  ];

  final List<CartOfferItemEntity> _offerItems = [];
  final List<CartReturnedMealItemEntity> _returnedMealItems = [];

  String get _cookId => _mealItems.isNotEmpty ? _meal1.cookId : '';

  @override
  Future<CartEntity> getCart() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return CartEntity(
      customerId: 'customer-1',
      cookId: _mealItems.isEmpty && _offerItems.isEmpty ? null : _cookId,
      mealItems: List.unmodifiable(_mealItems),
      offerItems: List.unmodifiable(_offerItems),
      returnedMealItems: List.unmodifiable(_returnedMealItems),
    );
  }

  /// Adds a meal from Meal Details into this same in-memory cart — merges
  /// into an existing line (same meal + selling option) instead of adding a
  /// duplicate row, matching how a real cart API would behave.
  @override
  Future<void> addItem({
    required MealEntity meal,
    required SellingOptionEntity sellingOption,
    required int quantity,
    String? note,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final existingIndex = _mealItems.indexWhere(
      (item) => item.mealId == meal.id && item.sellingOptionId == sellingOption.id,
    );
    if (existingIndex != -1) {
      final existing = _mealItems[existingIndex];
      _mealItems[existingIndex] = existing.copyWith(
        quantity: existing.quantity + quantity,
        note: note ?? existing.note,
      );
      return;
    }
    _mealItems.add(CartMealItemEntity(
      id: 'cart-${DateTime.now().microsecondsSinceEpoch}',
      mealId: meal.id,
      mealName: meal.name,
      mealImageUrl: meal.imageUrl,
      sellingOptionId: sellingOption.id,
      sellingOptionLabel: sellingOption.label,
      unitPrice: sellingOption.price,
      quantity: quantity,
      note: note,
    ));
  }

  @override
  Future<void> updateQuantity(String cartItemId, int quantity) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final mealIndex = _mealItems.indexWhere((item) => item.id == cartItemId);
    if (mealIndex != -1) {
      if (quantity <= 0) {
        _mealItems.removeAt(mealIndex);
      } else {
        _mealItems[mealIndex] = _mealItems[mealIndex].copyWith(quantity: quantity);
      }
      return;
    }
    final offerIndex = _offerItems.indexWhere((item) => item.id == cartItemId);
    if (offerIndex != -1) {
      if (quantity <= 0) {
        _offerItems.removeAt(offerIndex);
      } else {
        _offerItems[offerIndex] = _offerItems[offerIndex].copyWith(quantity: quantity);
      }
    }
  }

  @override
  Future<void> removeItem(String cartItemId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _mealItems.removeWhere((item) => item.id == cartItemId);
    _offerItems.removeWhere((item) => item.id == cartItemId);
    _returnedMealItems.removeWhere((item) => item.id == cartItemId);
  }

  @override
  Future<void> updateSellingOption(String cartItemId, String sellingOptionId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _mealItems.indexWhere((item) => item.id == cartItemId);
    if (index == -1) return;
    final current = _mealItems[index];
    final meal = SampleCatalog.mealById(current.mealId);
    final option = meal.sellingOptions.firstWhere(
      (o) => o.id == sellingOptionId,
      orElse: () => meal.sellingOptions.first,
    );
    _mealItems[index] = CartMealItemEntity(
      id: current.id,
      mealId: current.mealId,
      mealName: current.mealName,
      mealImageUrl: current.mealImageUrl,
      sellingOptionId: option.id,
      sellingOptionLabel: option.label,
      unitPrice: option.price,
      quantity: current.quantity,
      note: current.note,
    );
  }
}
