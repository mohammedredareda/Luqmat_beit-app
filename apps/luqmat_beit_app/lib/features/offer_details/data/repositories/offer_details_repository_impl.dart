import 'package:core/core.dart';

import '../../../cart/domain/repositories/cart_repository.dart';
import '../../domain/repositories/offer_details_repository.dart';

/// Delegates to the same [CartRepository] the Cart screen reads from — so
/// an offer added here actually shows up there. Mirrors how
/// `MealDetailsRepositoryImpl.addReturnedMealToCart` delegates to
/// `CartRepository.addReturnedMeal`.
class OfferDetailsRepositoryImpl implements OfferDetailsRepository {
  OfferDetailsRepositoryImpl({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  final CartRepository _cartRepository;

  @override
  Future<Result<void>> addOfferToCart(
      {required String offerId, required int count}) {
    return _cartRepository.addOffer(offerId: offerId, count: count);
  }
}
