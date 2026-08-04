import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../../meal_management/data/datasources/fake_meal_remote_data_source.dart';
import '../../../shared/data/datasources/fake_discounts_remote_data_source.dart';
import '../../../shared/domain/discount_form_submission.dart';
import '../../domain/repositories/edit_discount_repository.dart';

@LazySingleton(as: EditDiscountRepository)
class EditDiscountRepositoryImpl implements EditDiscountRepository {
  EditDiscountRepositoryImpl(this._discountsDataSource, this._mealDataSource);

  final FakeDiscountsRemoteDataSource _discountsDataSource;
  final FakeMealRemoteDataSource _mealDataSource;

  @override
  Future<
      Result<
          ({
            DiscountEntity discount,
            List<SellingOptionEntity> mealSellingOptions,
            double mealPrice,
          })>> getDiscount(String discountId) {
    return guard(() async {
      final discountModel = await _discountsDataSource.getDiscountById(discountId);
      if (discountModel == null) throw const NotFoundException('Discount not found');
      final mealModel = await _mealDataSource.getMealById(discountModel.mealId);
      if (mealModel == null) throw const NotFoundException('Meal not found');
      final meal = mealModel.toEntity();
      return (
        discount: discountModel.toEntity(),
        mealSellingOptions: meal.sellingOptions,
        mealPrice: meal.displayPrice,
      );
    });
  }

  @override
  Future<Result<DiscountEntity>> updateDiscount(String discountId, DiscountUpdateInput input) {
    return guard(() async {
      final existing = await _discountsDataSource.getDiscountById(discountId);
      if (existing == null) throw const NotFoundException('Discount not found');

      final updated = existing.copyWith(
        percentage: input.percentage,
        mode: input.mode,
        durationDays: input.durationDays,
        clearDurationDays: input.mode != DiscountRestrictionMode.duration,
        usageLimit: input.usageLimit,
        clearUsageLimit: input.mode != DiscountRestrictionMode.usage,
      );

      final saved = await _discountsDataSource.updateDiscount(updated);
      return saved.toEntity();
    });
  }
}
