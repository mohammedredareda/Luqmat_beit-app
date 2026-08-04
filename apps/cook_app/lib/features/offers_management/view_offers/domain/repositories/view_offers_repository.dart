import 'package:core/core.dart';

abstract class ViewOffersRepository {
  Future<Result<({List<OfferEntity> offers, List<DiscountEntity> discounts})>>
      getOffersAndDiscounts(String cookId);
}
