import 'package:core/core.dart';

import '../../../shared/data/datasources/discounts_remote_data_source.dart';
import '../../../shared/domain/discount_form_submission.dart';
import '../../../shared/domain/repositories/selectable_meals_repository.dart';
import '../../domain/repositories/edit_discount_repository.dart';

class EditDiscountRepositoryImpl implements EditDiscountRepository {
  EditDiscountRepositoryImpl(this._dataSource, this._selectableMealsRepository);

  final DiscountsRemoteDataSource _dataSource;
  final SelectableMealsRepository _selectableMealsRepository;

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
      // options (see DiscountModel.fromApiJson's doc comment), so look the
      // meal up separately — same datasource the meal-picker uses — for an
      // accurate "prices after discount" preview. Degrades to an empty
      // preview rather than failing the whole load if that lookup fails.
      final mealResult = await _selectableMealsRepository.getMealById(discountModel.mealId);
      final meal = mealResult.fold((meal) => meal, (_) => null);
      return (
        discount: discountModel.toEntity(),
        mealName: discountModel.mealName,
        mealImageUrl: discountModel.mealImageUrl,
        mealSellingOptions: meal?.sellingOptions ?? const <SellingOptionEntity>[],
        mealPrice: meal?.startingPrice ?? discountModel.mealBasePrice,
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
