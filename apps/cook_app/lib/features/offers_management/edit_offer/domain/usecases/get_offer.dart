import 'package:core/core.dart';

import '../repositories/edit_offer_repository.dart';

class GetOffer {
  GetOffer(this._repository);

  final EditOfferRepository _repository;

  Future<
      Result<
          ({
            OfferEntity offer,
            String? imageUrl,
            List<OfferMealSnapshot> mealDrafts,
          })>> call(String offerId) => _repository.getOffer(offerId);
}
