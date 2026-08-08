import 'package:core/core.dart';

abstract class DeleteDiscountRepository {
  Future<Result<void>> deleteDiscount(String discountId);
}
