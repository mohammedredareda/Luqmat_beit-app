import 'package:cook_app/shared/current_cook_id.dart';
import 'package:cook_app/features/offers_management/delete_discount/data/repositories/delete_discount_repository_impl.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_discounts_remote_data_source.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeDiscountsRemoteDataSource dataSource;
  late DeleteDiscountRepositoryImpl repository;

  setUp(() {
    dataSource = FakeDiscountsRemoteDataSource();
    repository = DeleteDiscountRepositoryImpl(dataSource);
  });

  test('deleteDiscount on a seeded id returns Result.success and excludes it from getMyDiscounts',
      () async {
    final result = await repository.deleteDiscount('discount-1');

    expect(result, isA<Success<void>>());
    final myDiscounts = await dataSource.getMyDiscounts(currentCookId);
    expect(myDiscounts.any((d) => d.id == 'discount-1'), isFalse);
  });

  test('deleteDiscount on an unknown id returns Result.failure(NotFoundException)', () async {
    final result = await repository.deleteDiscount('does-not-exist');

    expect(result, isA<Failure<void>>());
    expect((result as Failure<void>).exception, isA<NotFoundException>());
  });
}
