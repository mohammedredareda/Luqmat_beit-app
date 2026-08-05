import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/edit_offer_repository.dart';

@injectable
class GetOffer {
  GetOffer(this._repository);

  final EditOfferRepository _repository;

  Future<Result<OfferEntity>> call(String offerId) => _repository.getOffer(offerId);
}
