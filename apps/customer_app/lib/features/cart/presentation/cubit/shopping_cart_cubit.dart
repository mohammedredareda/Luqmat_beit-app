import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../orders/domain/usecases/confirm_order.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/remove_cart_item.dart';
import '../../domain/usecases/update_cart_item_quantity.dart';
import 'shopping_cart_state.dart';

/// Flat delivery fee applied whenever the cart is non-empty. There is no
/// delivery-quote backend yet, so this stands in until CU-17/checkout
/// wires a real quote.
const double _flatDeliveryFee = 10;

class ShoppingCartCubit extends Cubit<ShoppingCartState> {
  ShoppingCartCubit(
    this._getCartItems,
    this._updateCartItemQuantity,
    this._removeCartItem,
    this._repository,
    this._confirmOrder,
  ) : super(const ShoppingCartState.initial());

  final GetCartItems _getCartItems;
  final UpdateCartItemQuantity _updateCartItemQuantity;
  final RemoveCartItem _removeCartItem;
  // Selling-option changes are not one of the three named use cases in the
  // brief (get/update-quantity/remove), so this calls the repository
  // directly rather than adding a fourth single-method usecase class.
  final CartRepository _repository;
  final ConfirmOrder _confirmOrder;

  Future<void> loadCart() async {
    emit(const ShoppingCartState.loading());
    final result = await _getCartItems();
    result.fold(
      (items) => _emitItems(items),
      (exception) => emit(ShoppingCartState.failure(exception)),
    );
  }

  Future<void> changeQuantity(String cartItemId, int quantity) async {
    final result = await _updateCartItemQuantity(cartItemId, quantity);
    result.fold(
      (_) async {
        final refreshed = await _getCartItems();
        refreshed.fold(
          (items) => _emitItems(items),
          (exception) => emit(ShoppingCartState.failure(exception)),
        );
      },
      (exception) => emit(ShoppingCartState.failure(exception)),
    );
  }

  Future<void> removeItem(String cartItemId) async {
    final result = await _removeCartItem(cartItemId);
    result.fold(
      (_) async {
        final refreshed = await _getCartItems();
        refreshed.fold(
          (items) => _emitItems(items),
          (exception) => emit(ShoppingCartState.failure(exception)),
        );
      },
      (exception) => emit(ShoppingCartState.failure(exception)),
    );
  }

  Future<void> changeSellingOption(String cartItemId, String sellingOptionId) async {
    final result = await _repository.updateSellingOption(cartItemId, sellingOptionId);
    result.fold(
      (_) async {
        final refreshed = await _getCartItems();
        refreshed.fold(
          (items) => _emitItems(items),
          (exception) => emit(ShoppingCartState.failure(exception)),
        );
      },
      (exception) => emit(ShoppingCartState.failure(exception)),
    );
  }

  /// Places the order for the current cart (single-cook — the backend's
  /// `/order/confirm` takes one `cook_id`, matching this app's current
  /// single-cook cart model) and returns the new order id, or `null` on
  /// failure (a failure state is emitted in that case).
  Future<String?> checkout() async {
    final current = state;
    if (current is! ShoppingCartLoaded || current.items.isEmpty) return null;

    final result = await _confirmOrder(
      cookId: current.items.first.meal.cookId,
      items: current.items,
      deliveryFee: current.deliveryFee,
    );
    return result.fold(
      (orderId) => orderId,
      (exception) {
        emit(ShoppingCartState.failure(exception));
        return null;
      },
    );
  }

  void _emitItems(List<CartItemEntity> items) {
    if (items.isEmpty) {
      emit(const ShoppingCartState.empty());
      return;
    }
    final subtotal = items.fold<double>(0, (sum, item) => sum + item.subtotal);
    emit(ShoppingCartState.loaded(items, subtotal: subtotal, deliveryFee: _flatDeliveryFee));
  }
}
