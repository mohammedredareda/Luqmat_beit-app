import 'package:cook_app/features/offers_management/edit_offer/data/repositories/edit_offer_repository_impl.dart';
import 'package:cook_app/features/offers_management/edit_offer/domain/repositories/edit_offer_repository.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_offers_remote_data_source.dart';
import 'package:cook_app/features/offers_management/shared/domain/offer_form_submission.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeOffersRemoteDataSource dataSource;
  late EditOfferRepositoryImpl repository;

  setUp(() {
    dataSource = FakeOffersRemoteDataSource();
    repository = EditOfferRepositoryImpl(dataSource);
  });

  test('getOffer on the seeded offer-1 returns its data', () async {
    final result = await repository.getOffer('offer-1');

    expect(result, isA<Success<({OfferEntity offer, String? imageUrl, List<OfferMealSnapshot> mealDrafts})>>());
    final bundle = (result
            as Success<({OfferEntity offer, String? imageUrl, List<OfferMealSnapshot> mealDrafts})>)
        .data;
    expect(bundle.offer.id, 'offer-1');
    expect(bundle.mealDrafts, hasLength(3));
  });

  test('getOffer on an unknown id returns Result.failure(NotFoundException)', () async {
    final result = await repository.getOffer('does-not-exist');

    expect(
      result,
      isA<Failure<({OfferEntity offer, String? imageUrl, List<OfferMealSnapshot> mealDrafts})>>(),
    );
  });

  test('updateOffer mutates and a subsequent getMyOffers reflects it', () async {
    const submission = OfferFormSubmission(
      name: 'اسم محدث',
      description: 'وصف محدث',
      totalPrice: 150,
      durationDays: 20,
      isActive: false,
      includedMeals: [],
    );

    final result = await repository.updateOffer('offer-1', submission);

    expect(result, isA<Success<OfferEntity>>());
    final updated = (result as Success<OfferEntity>).data;
    expect(updated.name, 'اسم محدث');
    expect(updated.totalPrice, 150);
    expect(updated.isActive, isFalse);

    final myOffers = await dataSource.getMyOffers('cook-1');
    expect(myOffers.firstWhere((o) => o.id == 'offer-1').name, 'اسم محدث');
  });
}
