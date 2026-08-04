import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/delete_offer_repository.dart';

@injectable
class DeleteOffer {
  DeleteOffer(this._repository);

  final DeleteOfferRepository _repository;

  Future<Result<void>> call(String offerId) => _repository.deleteOffer(offerId);
}
