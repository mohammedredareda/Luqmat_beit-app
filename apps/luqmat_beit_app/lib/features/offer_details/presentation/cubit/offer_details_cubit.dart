import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_offer_to_cart.dart';
import 'offer_details_state.dart';

class OfferDetailsCubit extends Cubit<OfferDetailsState> {
  OfferDetailsCubit(this._addOfferToCart)
      : super(const OfferDetailsState.idle());

  final AddOfferToCart _addOfferToCart;

  void incrementQuantity() => _setQuantity(state.quantity + 1);

  void decrementQuantity() {
    if (state.quantity <= 1) return;
    _setQuantity(state.quantity - 1);
  }

  void _setQuantity(int quantity) {
    if (state is OfferDetailsSubmitting) return;
    emit(OfferDetailsState.idle(quantity: quantity));
  }

  Future<void> addToCart(String offerId) async {
    if (state is OfferDetailsSubmitting) return;
    final quantity = state.quantity;
    emit(OfferDetailsState.submitting(quantity: quantity));
    final result = await _addOfferToCart(offerId: offerId, count: quantity);
    result.fold(
      (_) => emit(OfferDetailsState.addedToCart(quantity: quantity)),
      (exception) => emit(
          OfferDetailsState.failure(quantity: quantity, exception: exception)),
    );
  }

  /// Called after the "تمت الإضافة إلى السلة" snackbar is shown, so a
  /// second tap can submit again instead of staying stuck on the
  /// just-added confirmation state.
  void acknowledgeAddedToCart() {
    if (state case OfferDetailsAddedToCart(:final quantity)) {
      emit(OfferDetailsState.idle(quantity: quantity));
    }
  }

  void acknowledgeFailure() {
    if (state case OfferDetailsFailure(:final quantity)) {
      emit(OfferDetailsState.idle(quantity: quantity));
    }
  }
}
