import 'package:core/core.dart';

abstract class OfferDetailsRepository {
  Future<Result<void>> addOfferToCart(
      {required String offerId, required int count});
}
