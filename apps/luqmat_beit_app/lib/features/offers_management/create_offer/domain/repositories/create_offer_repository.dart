import 'package:core/core.dart';

import '../../../shared/domain/offer_form_submission.dart';

abstract class CreateOfferRepository {
  Future<Result<OfferEntity>> createOffer(OfferFormSubmission submission);
}
