import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../orders/domain/usecases/confirm_returned_meals_order.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/remove_cart_item.dart';
import '../../domain/usecases/update_cart_item_quantity.dart';
import 'shopping_cart_state.dart';

/// Flat delivery fee applied per cook whenever that cook's section is
/// non-empty. There is no delivery-quote backend yet, so this stands in
/// until CU-17/checkout wires a real quote.
const double _flatDeliveryFee = 10;

class ShoppingCartCubit extends Cubit<ShoppingCartState> {
  ShoppingCartCubit(
    this._getCartItems,
    this._updateCartItemQuantity,
    this._removeCartItem,
    this._repository,
    this._confirmReturnedMealsOrder,
    this._profileCache,
  ) : super(const ShoppingCartState.initial());

  final GetCartItems _getCartItems;
  final UpdateCartItemQuantity _updateCartItemQuantity;
  final RemoveCartItem _removeCartItem;
  // Selling-option changes are not one of the three named use cases in the
  // brief (get/update-quantity/remove), so this calls the repository
  // directly rather than adding a fourth single-method usecase class.
  final CartRepository _repository;
  final ConfirmReturnedMealsOrder _confirmReturnedMealsOrder;
  final UserProfileCache _profileCache;

  Future<void> loadCart() async {
    emit(const ShoppingCartState.loading());
    final result = await _getCartItems();
    if (isClosed) return;
    result.fold(
      (cart) => _emitCart(cart),
      (exception) => emit(ShoppingCartState.failure(exception)),
    );
  }

  Future<void> changeQuantity(String cartItemId, int quantity) async {
    final result = await _updateCartItemQuantity(cartItemId, quantity);
    if (isClosed) return;
    result.fold(
      (_) => _reload(),
      (exception) => emit(ShoppingCartState.failure(exception)),
    );
  }

  Future<void> removeItem(String cartItemId) async {
    final result = await _removeCartItem(cartItemId);
    if (isClosed) return;
    result.fold(
      (_) => _reload(),
      (exception) => emit(ShoppingCartState.failure(exception)),
    );
  }

  Future<void> changeSellingOption(
      String cartItemId, String sellingOptionId) async {
    final result =
        await _repository.updateSellingOption(cartItemId, sellingOptionId);
    if (isClosed) return;
    result.fold(
      (_) => _reload(),
      (exception) => emit(ShoppingCartState.failure(exception)),
    );
  }

  Future<void> changeNote(String cartItemId, String note) async {
    final result = await _repository.updateNote(cartItemId, note);
    if (isClosed) return;
    result.fold(
      (_) => _reload(),
      (exception) => emit(ShoppingCartState.failure(exception)),
    );
  }

  Future<void> _reload() async {
    final refreshed = await _getCartItems();
    if (isClosed) return;
    refreshed.fold(
      (cart) => _emitCart(cart),
      (exception) => emit(ShoppingCartState.failure(exception)),
    );
  }

  /// Confirms every "من نصيبك" (returned/salvage meal) line in one order —
  /// a distinct request from [confirmOrder] (no `cook_id`, flagged with
  /// `is_returned_meals_order` instead), since these aren't grouped under
  /// any cook section in the cart.
  Future<Result<String>> confirmReturnedMeals() {
    final current = state;
    if (current is! ShoppingCartLoaded ||
        current.cart.returnedMealItems.isEmpty) {
      return Future.value(const Result.failure(
        UnknownException('لا توجد عناصر من نصيبك لتأكيدها.'),
      ));
    }
    final cached = _profileCache.read();
    return _confirmReturnedMealsOrder(
      returnedMealItems: current.cart.returnedMealItems,
      latitude: cached.latitude,
      longitude: cached.longitude,
    );
  }

  void _emitCart(CartEntity cart) {
    if (cart.isEmpty) {
      emit(const ShoppingCartState.empty());
      return;
    }
    emit(ShoppingCartState.loaded(cart, deliveryFee: _flatDeliveryFee));
  }
}
