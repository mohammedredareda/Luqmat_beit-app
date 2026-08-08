import 'package:core/core.dart';

import '../../../shared/domain/offer_form_submission.dart';

/// Per-meal pricing/selling-option snapshot — [OfferMealEntity] only
/// carries display fields (`mealId`/`mealName`/`mealImageUrl`/
/// `variationQuantity`), not the pricing/selling-option data the edit
/// form needs, so this bundles the richer data-layer view instead.
typedef OfferMealSnapshot = ({
  String mealId,
  String mealName,
  String mealImageUrl,
  String? sellingOptionId,
  String? sellingOptionLabel,
  double unitPrice,
  int quantity,
});

abstract class EditOfferRepository {
  Future<
      Result<
          ({
            OfferEntity offer,
            String? imageUrl,
            List<OfferMealSnapshot> mealDrafts,
          })>> getOffer(String offerId);

  Future<Result<OfferEntity>> updateOffer(String offerId, OfferFormSubmission submission);
}
