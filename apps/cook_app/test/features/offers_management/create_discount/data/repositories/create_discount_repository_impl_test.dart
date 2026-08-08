import 'package:cook_app/features/offers_management/create_discount/data/repositories/create_discount_repository_impl.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_discounts_remote_data_source.dart';
import 'package:cook_app/features/offers_management/shared/domain/discount_form_submission.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeDiscountsRemoteDataSource dataSource;
  late CreateDiscountRepositoryImpl repository;

  setUp(() {
    dataSource = FakeDiscountsRemoteDataSource();
    repository = CreateDiscountRepositoryImpl(dataSource);
  });

  const submission = DiscountFormSubmission(
    mealId: 'meal-4',
    mealName: 'مسقعة باذنجان',
    mealImageUrl: 'https://picsum.photos/seed/moussaka/200/200',
    mealBasePrice: 25,
    discountPercentage: 25,
    discountDurationDays: 7,
  );

  test('createDiscount returns Result.success with the new discount', () async {
    final result = await repository.createDiscount(submission);

    expect(result, isA<Success<DiscountEntity>>());
    final discount = (result as Success<DiscountEntity>).data;
    expect(discount.mealId, 'meal-4');
    expect(discount.discountPercentage, 25);
    expect(discount.usageCount, 0);
  });
}
