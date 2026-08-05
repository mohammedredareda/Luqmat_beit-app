import 'package:cook_app/features/offers_management/create_offer/data/repositories/create_offer_repository_impl.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_offers_remote_data_source.dart';
import 'package:cook_app/features/offers_management/shared/domain/offer_form_submission.dart';
import 'package:cook_app/features/offers_management/view_offers/data/repositories/view_offers_repository_impl.dart';
import 'package:cook_app/features/offers_management/view_offers/domain/entities/offer_feed_item_entity.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_discounts_remote_data_source.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeOffersRemoteDataSource dataSource;
  late CreateOfferRepositoryImpl repository;

  setUp(() {
    dataSource = FakeOffersRemoteDataSource();
    repository = CreateOfferRepositoryImpl(dataSource);
  });

  const submission = OfferFormSubmission(
    name: 'عرض الأصدقاء',
    description: 'وصف',
    totalPrice: 80,
    durationDays: 10,
    isActive: true,
    includedMeals: [
      OfferMealInput(
        mealId: 'meal-1',
        mealName: 'كبسة دجاج منزلية',
        mealImageUrl: 'https://picsum.photos/seed/kabsa/200/200',
        unitPrice: 45,
        quantity: 2,
      ),
    ],
  );

  test('createOffer returns Result.success with the new offer', () async {
    final result = await repository.createOffer(submission);

    expect(result, isA<Success<OfferEntity>>());
    final offer = (result as Success<OfferEntity>).data;
    expect(offer.name, 'عرض الأصدقاء');
    expect(offer.includedMeals, hasLength(1));
  });

  test('the created offer is visible via view_offers reading the same shared datasource', () async {
    await repository.createOffer(submission);

    final viewOffersRepository = ViewOffersRepositoryImpl(dataSource, FakeDiscountsRemoteDataSource());
    final result = await viewOffersRepository.getOffersFeed(currentCookId, pageSize: 1000);
    final items = (result as Success<PaginatedResult<OfferFeedItemEntity>>).data.items;

    expect(
      items.any((i) => i is OfferFeedOfferItem && i.offer.name == 'عرض الأصدقاء'),
      isTrue,
    );
  });
}
