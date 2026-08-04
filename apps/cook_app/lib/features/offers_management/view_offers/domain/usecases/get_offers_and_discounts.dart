import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/view_offers_repository.dart';

@injectable
class GetOffersAndDiscounts {
  GetOffersAndDiscounts(this._repository);

  final ViewOffersRepository _repository;

  Future<Result<({List<OfferEntity> offers, List<DiscountEntity> discounts})>> call(
    String cookId,
  ) =>
      _repository.getOffersAndDiscounts(cookId);
}
