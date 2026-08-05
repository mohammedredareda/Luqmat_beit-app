import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/delete_discount_repository.dart';

@injectable
class DeleteDiscount {
  DeleteDiscount(this._repository);

  final DeleteDiscountRepository _repository;

  Future<Result<void>> call(String discountId) => _repository.deleteDiscount(discountId);
}
