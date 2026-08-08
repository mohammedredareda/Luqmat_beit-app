import 'package:core/core.dart';

import '../../../shared/domain/discount_form_submission.dart';
import '../repositories/edit_discount_repository.dart';

class UpdateDiscount {
  UpdateDiscount(this._repository);

  final EditDiscountRepository _repository;

  Future<Result<DiscountEntity>> call(String discountId, DiscountUpdateInput input) =>
      _repository.updateDiscount(discountId, input);
}
