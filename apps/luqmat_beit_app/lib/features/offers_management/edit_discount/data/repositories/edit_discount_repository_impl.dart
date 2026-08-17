import 'package:core/core.dart';

import '../../../shared/data/datasources/discounts_remote_data_source.dart';
import '../../../shared/domain/discount_form_submission.dart';
import '../../domain/repositories/edit_discount_repository.dart';

class EditDiscountRepositoryImpl implements EditDiscountRepository {
  EditDiscountRepositoryImpl(this._dataSource);

  final DiscountsRemoteDataSource _dataSource;

  @override
  Future<
      Result<
          ({
            DiscountEntity discount,
            String mealName,
            String mealImageUrl,
            List<SellingOptionEntity> mealSellingOptions,
            double mealPrice,
          })>> getDiscount(String discountId) {
    return guard(() async {
      final discountModel = await _dataSource.getDiscountById(discountId);
      if (discountModel == null) throw const NotFoundException('Discount not found');
      // The real detail endpoint's nested `meal` has no price/selling
      // options — `mealSellingOptions`/`mealPrice` are unavailable, unlike
      // when this read from the meal datasource directly. The edit form
      // renders an empty "current price" preview in that case rather than
      // a fabricated number (see DiscountModel.fromApiJson's doc comment).
      return (
        discount: discountModel.toEntity(),
        mealName: discountModel.mealName,
        mealImageUrl: discountModel.mealImageUrl,
        mealSellingOptions: <SellingOptionEntity>[],
        mealPrice: discountModel.mealBasePrice,
      );
    });
  }

  @override
  Future<Result<DiscountEntity>> updateDiscount(String discountId, DiscountUpdateInput input) {
    return guard(() async {
      final existing = await _dataSource.getDiscountById(discountId);
      if (existing == null) throw const NotFoundException('Discount not found');

      final updated = existing.copyWith(
        discountPercentage: input.discountPercentage,
        discountDurationDays: input.discountDurationDays,
        usageNumberLimit: input.usageNumberLimit,
        clearUsageNumberLimit: input.usageNumberLimit == null,
      );

      final saved = await _dataSource.updateDiscount(updated);
      return saved.toEntity();
    });
  }
}
