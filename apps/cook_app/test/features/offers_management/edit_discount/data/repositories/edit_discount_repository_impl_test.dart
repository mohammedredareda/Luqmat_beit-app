import 'package:cook_app/features/meal_management/data/datasources/fake_meal_remote_data_source.dart';
import 'package:cook_app/features/offers_management/edit_discount/data/repositories/edit_discount_repository_impl.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_discounts_remote_data_source.dart';
import 'package:cook_app/features/offers_management/shared/domain/discount_form_submission.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeDiscountsRemoteDataSource discountsDataSource;
  late FakeMealRemoteDataSource mealDataSource;
  late EditDiscountRepositoryImpl repository;

  setUp(() {
    discountsDataSource = FakeDiscountsRemoteDataSource();
    mealDataSource = FakeMealRemoteDataSource();
    repository = EditDiscountRepositoryImpl(discountsDataSource, mealDataSource);
  });

  test('getDiscount on the seeded discount-1 returns the live meal-1 price/options bundle',
      () async {
    final result = await repository.getDiscount('discount-1');

    expect(
      result,
      isA<
          Success<
              ({
                DiscountEntity discount,
                List<SellingOptionEntity> mealSellingOptions,
                double mealPrice,
              })>>(),
    );
    final bundle = (result
            as Success<
                ({
                  DiscountEntity discount,
                  List<SellingOptionEntity> mealSellingOptions,
                  double mealPrice,
                })>)
        .data;
    expect(bundle.discount.id, 'discount-1');
    expect(bundle.mealPrice, 45);
    expect(bundle.mealSellingOptions, isEmpty);
  });

  test('updateDiscount mutates percentage/mode and a subsequent getMyDiscounts reflects it',
      () async {
    const input = DiscountUpdateInput(
      percentage: 35,
      mode: DiscountRestrictionMode.usage,
      usageLimit: 10,
    );

    final result = await repository.updateDiscount('discount-1', input);

    expect(result, isA<Success<DiscountEntity>>());
    final updated = (result as Success<DiscountEntity>).data;
    expect(updated.percentage, 35);
    expect(updated.mode, DiscountRestrictionMode.usage);
    expect(updated.usageLimit, 10);

    final myDiscounts = await discountsDataSource.getMyDiscounts(updated.cookId);
    expect(myDiscounts.firstWhere((d) => d.id == 'discount-1').percentage, 35);
  });

  test('switching modes clears the other field to null', () async {
    const input = DiscountUpdateInput(
      percentage: 35,
      mode: DiscountRestrictionMode.usage,
      usageLimit: 10,
    );

    final result = await repository.updateDiscount('discount-1', input);

    final updated = (result as Success<DiscountEntity>).data;
    expect(updated.durationDays, isNull);
  });
}
