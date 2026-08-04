import 'package:core/core.dart';

import '../../../shared/domain/offer_form_submission.dart';

abstract class EditOfferRepository {
  Future<Result<OfferEntity>> getOffer(String offerId);

  Future<Result<OfferEntity>> updateOffer(
    String offerId,
    OfferFormSubmission submission,
  );
}
