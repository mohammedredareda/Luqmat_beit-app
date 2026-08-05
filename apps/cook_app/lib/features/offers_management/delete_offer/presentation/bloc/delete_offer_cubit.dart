import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/delete_offer.dart';
import 'delete_offer_state.dart';

/// CK-15 Delete Offer. A single linear confirm-then-mutate flow, mirroring
/// `DeleteMealCubit` — no order/cart-blocking check at all (decision 6).
@injectable
class DeleteOfferCubit extends Cubit<DeleteOfferState> {
  DeleteOfferCubit(this._deleteOffer) : super(const DeleteOfferState.initial());

  final DeleteOffer _deleteOffer;

  Future<void> delete(String offerId) async {
    emit(const DeleteOfferState.submitting());
    final result = await _deleteOffer(offerId);
    result.fold(
      (_) => emit(DeleteOfferState.success(offerId)),
      (exception) => emit(DeleteOfferState.failure(exception)),
    );
  }
}
