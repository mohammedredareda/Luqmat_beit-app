import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../orders/domain/usecases/confirm_order.dart';
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
    this._confirmOrder,
    this._profileCache,
  ) : super(const ShoppingCartState.initial());

  final GetCartItems _getCartItems;
  final UpdateCartItemQuantity _updateCartItemQuantity;
  final RemoveCartItem _removeCartItem;
  // Selling-option changes are not one of the three named use cases in the
  // brief (get/update-quantity/remove), so this calls the repository
  // directly rather than adding a fourth single-method usecase class.
  final CartRepository _repository;
  final ConfirmOrder _confirmOrder;
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

  Future<void> changeSellingOption(String cartItemId, String sellingOptionId) async {
    final result = await _repository.updateSellingOption(cartItemId, sellingOptionId);
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

  /// Places one order per non-empty cook section (the mockup's fixed
  /// "تأكيد الكل" button) — the backend only ever confirms one cook per
  /// call, so "confirm all" runs every group's confirm in sequence,
  /// stopping at the first failure. Returns every order id confirmed
  /// before that, plus the exception that stopped it (if any) — a failed
  /// checkout (e.g. "this cook is currently closed", stale prices) is a
  /// business-rule rejection, not a reason to blow away the cart the
  /// customer is still looking at, so this reports the error via the
  /// return value instead of routing it through [ShoppingCartState.failure]
  /// (which the page would render as a full-screen "couldn't load the
  /// cart" error). [locationByCookId] carries each section's own
  /// "تحديد الموقع" pick (address text + coordinates); a cook with no entry
  /// falls back to the cached registration-time address/location.
  Future<({List<String> orderIds, AppException? error})> checkoutAll({
    Map<String, ({String address, double? latitude, double? longitude})> locationByCookId =
        const {},
  }) async {
    final current = state;
    if (current is! ShoppingCartLoaded) return (orderIds: <String>[], error: null);

    final confirmedOrderIds = <String>[];
    for (final group in current.cart.cookGroups) {
      if (group.isEmpty) continue;
      final location = locationByCookId[group.cookId];
      final result = await _confirmOrder(
        cookId: group.cookId,
        deliveryAddress: location?.address ?? _profileCache.read().address ?? '',
        deliveryFee: _flatDeliveryFee,
        mealItems: group.mealItems,
        offerItems: group.offerItems,
        latitude: location?.latitude,
        longitude: location?.longitude,
      );
      if (isClosed) break;
      AppException? error;
      final orderId = result.fold(
        (id) => id,
        (exception) {
          error = exception;
          return null;
        },
      );
      if (orderId == null) return (orderIds: confirmedOrderIds, error: error);
      confirmedOrderIds.add(orderId);
    }
    return (orderIds: confirmedOrderIds, error: null);
  }

  void _emitCart(CartEntity cart) {
    if (cart.isEmpty) {
      emit(const ShoppingCartState.empty());
      return;
    }
    emit(ShoppingCartState.loaded(cart, deliveryFee: _flatDeliveryFee));
  }
}
