import 'package:cook_app/shared/current_cook_id.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_discounts_remote_data_source.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_offers_remote_data_source.dart';
import 'package:cook_app/features/offers_management/view_offers/data/repositories/view_offers_repository_impl.dart';
import 'package:cook_app/features/offers_management/view_offers/domain/entities/offer_feed_filter.dart';
import 'package:cook_app/features/offers_management/view_offers/domain/entities/offer_feed_item_entity.dart';
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

  test('returns both seeded lists merged into one feed', () async {
    final result = await repository.getOffersFeed(currentCookId, pageSize: 1000);

    expect(result, isA<Success<PaginatedResult<OfferFeedItemEntity>>>());
    final page = (result as Success<PaginatedResult<OfferFeedItemEntity>>).data;
    expect(page.items.whereType<OfferFeedOfferItem>(), isNotEmpty);
    expect(page.items.whereType<OfferFeedDiscountItem>(), isNotEmpty);
    // The hand-seeded offer-1/discount-1/discount-2 plus the bulk-generated
    // fixtures should all be present.
    expect(page.items.any((i) => i is OfferFeedOfferItem && i.offer.id == 'offer-1'), isTrue);
    expect(
      page.items.any((i) => i is OfferFeedDiscountItem && i.discount.id == 'discount-1'),
      isTrue,
    );
  });

  test('a soft-deleted offer/discount is excluded', () async {
    await offersDataSource.deleteOffer('offer-1');
    await discountsDataSource.deleteDiscount('discount-1');

    final result = await repository.getOffersFeed(currentCookId, pageSize: 1000);
    final page = (result as Success<PaginatedResult<OfferFeedItemEntity>>).data;

    expect(page.items.any((i) => i is OfferFeedOfferItem && i.offer.id == 'offer-1'), isFalse);
    expect(
      page.items.any((i) => i is OfferFeedDiscountItem && i.discount.id == 'discount-1'),
      isFalse,
    );
  });

  test('paginates the merged feed and honors pageSize/hasMore', () async {
    final firstPage = await repository.getOffersFeed(currentCookId, pageSize: 10);
    final data = (firstPage as Success<PaginatedResult<OfferFeedItemEntity>>).data;
    expect(data.items, hasLength(10));
    expect(data.hasMore, isTrue);
    expect(data.nextCursor, isNotNull);
  });

  test('active filter excludes expired offers and discounts', () async {
    final result = await repository.getOffersFeed(
      currentCookId,
      filter: OfferFeedFilter.active,
      pageSize: 1000,
    );
    final page = (result as Success<PaginatedResult<OfferFeedItemEntity>>).data;

    for (final item in page.items) {
      switch (item) {
        case OfferFeedOfferItem(:final offer):
          expect(offer.isActive && offer.remainingDays > 0, isTrue);
        case OfferFeedDiscountItem(:final discount):
          final expired = (discount.remainingDays != null && discount.remainingDays! <= 0) ||
              (discount.remainingUsage != null && discount.remainingUsage! <= 0);
          expect(discount.isActive && !expired, isTrue);
      }
    }
  });
}
