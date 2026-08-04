import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/domain/offer_form_submission.dart';
import '../repositories/edit_offer_repository.dart';

@injectable
class UpdateOffer {
  UpdateOffer(this._repository);

  final EditOfferRepository _repository;

  Future<Result<OfferEntity>> call(String offerId, OfferFormSubmission submission) =>
      _repository.updateOffer(offerId, submission);
}
