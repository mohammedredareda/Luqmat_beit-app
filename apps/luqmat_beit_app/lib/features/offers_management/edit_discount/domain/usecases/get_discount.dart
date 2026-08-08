import 'package:core/core.dart';

import '../repositories/edit_discount_repository.dart';

class GetDiscount {
  GetDiscount(this._repository);

  final EditDiscountRepository _repository;

  Future<
      Result<
          ({
            DiscountEntity discount,
            String mealName,
            String mealImageUrl,
            List<SellingOptionEntity> mealSellingOptions,
            double mealPrice,
          })>> call(String discountId) => _repository.getDiscount(discountId);
}
