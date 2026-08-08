import 'package:core/core.dart';

import '../repositories/delete_offer_repository.dart';

class DeleteOffer {
  DeleteOffer(this._repository);

  final DeleteOfferRepository _repository;

  Future<Result<void>> call(String offerId) => _repository.deleteOffer(offerId);
}
