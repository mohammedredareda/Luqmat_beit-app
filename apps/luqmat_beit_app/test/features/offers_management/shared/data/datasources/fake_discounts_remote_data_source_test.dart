import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'package:luqmat_beit_app/features/offers_management/shared/data/datasources/fake_discounts_remote_data_source.dart';
import 'package:luqmat_beit_app/features/offers_management/shared/data/models/discount_model.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeDiscountsRemoteDataSource dataSource;

  setUp(() {
    dataSource = FakeDiscountsRemoteDataSource();
  });

  DiscountModel buildDiscount({String id = 'discount-new'}) => DiscountModel(
        id: id,
        cookId: currentCookId,
        mealId: 'meal-1',
        mealName: 'كبسة دجاج منزلية',
        mealImageUrl: 'https://picsum.photos/seed/kabsa/200/200',
        mealBasePrice: 45,
        discountPercentage: 10,
        discountDurationDays: 3,
        createdAt: DateTime.now(),
        expiryTime: DateTime.now().add(const Duration(days: 3)),
      );

  test('createDiscount appends and is retrievable via getMyDiscounts and getDiscountById', () async {
    final created = await dataSource.createDiscount(buildDiscount());

    final myDiscounts = await dataSource.getMyDiscounts(currentCookId);
    expect(myDiscounts.any((d) => d.id == created.id), isTrue);

    final byId = await dataSource.getDiscountById(created.id);
    expect(byId, isNotNull);
  });

  test('updateDiscount replaces the discount in place', () async {
    final created = await dataSource.createDiscount(buildDiscount());
    final updated = created.copyWith(discountPercentage: 30);

    final result = await dataSource.updateDiscount(updated);

    expect(result.discountPercentage, 30);
    final byId = await dataSource.getDiscountById(created.id);
    expect(byId!.discountPercentage, 30);
  });

  test('updateDiscount on an unknown id throws NotFoundException', () async {
    expect(
      () => dataSource.updateDiscount(buildDiscount(id: 'does-not-exist')),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('deleteDiscount on an unknown id throws NotFoundException', () async {
    expect(() => dataSource.deleteDiscount('does-not-exist'), throwsA(isA<NotFoundException>()));
  });

  test('deleteDiscount soft-deletes: excluded from getMyDiscounts and getDiscountById', () async {
    final created = await dataSource.createDiscount(buildDiscount());

    await dataSource.deleteDiscount(created.id);

    final myDiscounts = await dataSource.getMyDiscounts(currentCookId);
    expect(myDiscounts.any((d) => d.id == created.id), isFalse);
    expect(await dataSource.getDiscountById(created.id), isNull);
  });
}
