import 'package:core/core.dart';

import '../../../shared/domain/discount_form_submission.dart';

abstract class EditDiscountRepository {
  /// Bundles the discount with the target meal's *current* name/image/
  /// selling options/price (fresh, not a stale snapshot — [DiscountEntity]
  /// itself only carries `mealId`) so the per-variation "prices after
  /// discount" preview list is accurate.
  Future<
      Result<
          ({
            DiscountEntity discount,
            String mealName,
            String mealImageUrl,
            List<SellingOptionEntity> mealSellingOptions,
            double mealPrice,
          })>> getDiscount(String discountId);

  Future<Result<DiscountEntity>> updateDiscount(String discountId, DiscountUpdateInput input);
}
