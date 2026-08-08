import 'package:core/core.dart';

abstract class DeleteOfferRepository {
  Future<Result<void>> deleteOffer(String offerId);
}
