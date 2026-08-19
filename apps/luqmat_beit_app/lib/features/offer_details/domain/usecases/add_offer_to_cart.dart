import 'package:core/core.dart';

import '../repositories/offer_details_repository.dart';

class AddOfferToCart {
  const AddOfferToCart(this._repository);

  final OfferDetailsRepository _repository;

  Future<Result<void>> call({required String offerId, required int count}) {
    return _repository.addOfferToCart(offerId: offerId, count: count);
  }
}
