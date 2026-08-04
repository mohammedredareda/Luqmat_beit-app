import 'package:cook_app/shared/current_cook_id.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_discounts_remote_data_source.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_offers_remote_data_source.dart';
import 'package:cook_app/features/offers_management/view_offers/data/repositories/view_offers_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeOffersRemoteDataSource offersDataSource;
  late FakeDiscountsRemoteDataSource discountsDataSource;
  late ViewOffersRepositoryImpl repository;

  setUp(() {
    offersDataSource = FakeOffersRemoteDataSource();
    discountsDataSource = FakeDiscountsRemoteDataSource();
    repository = ViewOffersRepositoryImpl(offersDataSource, discountsDataSource);
  });

  test('returns both seeded lists combined', () async {
    final result = await repository.getOffersAndDiscounts(currentCookId);

    expect(
      result,
      isA<Success<({List<OfferEntity> offers, List<DiscountEntity> discounts})>>(),
    );
    final data =
        (result as Success<({List<OfferEntity> offers, List<DiscountEntity> discounts})>).data;
    expect(data.offers, hasLength(1));
    expect(data.discounts, hasLength(2));
  });

  test('a soft-deleted offer/discount is excluded', () async {
    await offersDataSource.deleteOffer('offer-1');
    await discountsDataSource.deleteDiscount('discount-1');

    final result = await repository.getOffersAndDiscounts(currentCookId);
    final data =
        (result as Success<({List<OfferEntity> offers, List<DiscountEntity> discounts})>).data;

    expect(data.offers, isEmpty);
    expect(data.discounts, hasLength(1));
  });
}
