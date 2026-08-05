import 'package:core/core.dart';

import '../../../shared/domain/discount_form_submission.dart';

abstract class EditDiscountRepository {
  /// Bundles the discount with the target meal's *current* selling
  /// options/price (fresh, not the entity's stale snapshot) so the
  /// per-variation "prices after discount" preview list is accurate.
  Future<
      Result<
          ({
            DiscountEntity discount,
            List<SellingOptionEntity> mealSellingOptions,
            double mealPrice,
          })>> getDiscount(String discountId);

  Future<Result<DiscountEntity>> updateDiscount(String discountId, DiscountUpdateInput input);
}
