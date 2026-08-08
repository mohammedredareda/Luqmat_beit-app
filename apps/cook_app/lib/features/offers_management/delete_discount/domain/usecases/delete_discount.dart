import 'package:core/core.dart';

import '../repositories/delete_discount_repository.dart';

class DeleteDiscount {
  DeleteDiscount(this._repository);

  final DeleteDiscountRepository _repository;

  Future<Result<void>> call(String discountId) => _repository.deleteDiscount(discountId);
}
