import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/domain/offer_form_submission.dart';
import '../repositories/create_offer_repository.dart';

@injectable
class CreateOffer {
  CreateOffer(this._repository);

  final CreateOfferRepository _repository;

  Future<Result<OfferEntity>> call(OfferFormSubmission submission) =>
      _repository.createOffer(submission);
}
