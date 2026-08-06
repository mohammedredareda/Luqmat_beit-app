import 'package:core/core.dart';

import '../../../../shared/mock/sample_catalog.dart';
import 'cart_data_source.dart';

/// Stands in for `cart_remote_data_source.dart` until a backend exists.
/// Holds the cart in an in-memory mutable list for the session so
/// quantity/remove/selling-option actions actually mutate what the
/// screen shows, without needing persistence yet.
class CartMockDataSource implements CartDataSource {
  final List<CartItemEntity> _items = [
    CartItemEntity(
      id: 'cart-1',
      meal: SampleCatalog.mealById('meal-1'),
      sellingOption: SampleCatalog.mealById('meal-1').sellingOptions.first,
      quantity: 2,
    ),
    CartItemEntity(
      id: 'cart-2',
      meal: SampleCatalog.mealById('meal-2'),
      sellingOption: SampleCatalog.mealById('meal-2').sellingOptions[1],
      quantity: 1,
      note: 'بدون بصل',
    ),
    CartItemEntity(
      id: 'cart-3',
      meal: SampleCatalog.mealById('meal-3'),
      sellingOption: SampleCatalog.mealById('meal-3').sellingOptions.first,
      quantity: 1,
    ),
  ];

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_items);
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
    final existingIndex = _items.indexWhere(
      (item) => item.meal.id == meal.id && item.sellingOption.id == sellingOption.id,
    );
    if (existingIndex != -1) {
      final existing = _items[existingIndex];
      _items[existingIndex] = existing.copyWith(
        quantity: existing.quantity + quantity,
        note: note ?? existing.note,
      );
      return;
    }
    _items.add(CartItemEntity(
      id: 'cart-${DateTime.now().microsecondsSinceEpoch}',
      meal: meal,
      sellingOption: sellingOption,
      quantity: quantity,
      note: note,
    ));
  }

  @override
  Future<void> updateQuantity(String cartItemId, int quantity) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index == -1) return;
    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = _items[index].copyWith(quantity: quantity);
    }
  }

  @override
  Future<void> removeItem(String cartItemId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _items.removeWhere((item) => item.id == cartItemId);
  }

  @override
  Future<void> updateSellingOption(String cartItemId, String sellingOptionId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index == -1) return;
    final current = _items[index];
    final option = current.meal.sellingOptions.firstWhere(
      (o) => o.id == sellingOptionId,
      orElse: () => current.sellingOption,
    );
    _items[index] = CartItemEntity(
      id: current.id,
      meal: current.meal,
      sellingOption: option,
      quantity: current.quantity,
      note: current.note,
    );
  }
}
