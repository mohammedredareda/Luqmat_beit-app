import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/edit_discount_repository.dart';

@injectable
class GetDiscount {
  GetDiscount(this._repository);

  final EditDiscountRepository _repository;

  Future<
      Result<
          ({
            DiscountEntity discount,
            List<SellingOptionEntity> mealSellingOptions,
            double mealPrice,
          })>> call(String discountId) => _repository.getDiscount(discountId);
}
