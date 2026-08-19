import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_cart_state.freezed.dart';

/// Multiple UI-distinct actions (quantity, remove, selling-option change)
/// but no server round-trip that branches into different UI outcomes —
/// a Cubit with a rich state is sufficient here, no Bloc events needed.
@freezed
sealed class ShoppingCartState with _$ShoppingCartState {
  const factory ShoppingCartState.initial() = ShoppingCartInitial;
  const factory ShoppingCartState.loading() = ShoppingCartLoading;
  const factory ShoppingCartState.loaded(
    CartEntity cart, {
    required double deliveryFee,
  }) = ShoppingCartLoaded;
  const factory ShoppingCartState.empty() = ShoppingCartEmpty;
  const factory ShoppingCartState.failure(AppException exception) =
      ShoppingCartFailure;
}
