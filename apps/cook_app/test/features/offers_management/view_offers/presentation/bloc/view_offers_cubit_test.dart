import '../../../../../support/bloc_test_helper.dart';
import 'package:cook_app/features/offers_management/view_offers/domain/entities/offer_feed_filter.dart';
import 'package:cook_app/features/offers_management/view_offers/domain/entities/offer_feed_item_entity.dart';
import 'package:cook_app/features/offers_management/view_offers/domain/usecases/get_offers_feed.dart';
import 'package:cook_app/features/offers_management/view_offers/presentation/bloc/view_offers_cubit.dart';
import 'package:cook_app/features/offers_management/view_offers/presentation/bloc/view_offers_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetOffersFeed extends Mock implements GetOffersFeed {}

void main() {
  late _MockGetOffersFeed getOffersFeed;

  setUpAll(() {
    registerFallbackValue(OfferFeedFilter.all);
  });

  setUp(() {
    getOffersFeed = _MockGetOffersFeed();
  });

  final offer = OfferEntity(
    id: 'offer-1',
    cookId: 'cook-1',
    name: 'لمة العائلة',
    description: '',
    totalPrice: 120,
    durationDays: 14,
    createdAt: DateTime.now(),
    expiryTime: DateTime.now().add(const Duration(days: 14)),
  );

  final discount = DiscountEntity(
    id: 'discount-1',
    mealId: 'meal-1',
    discountPercentage: 20,
    discountDurationDays: 5,
    createdAt: DateTime.now(),
    expiryTime: DateTime.now().add(const Duration(days: 5)),
  );

  const discountMealName = 'كبسة دجاج منزلية';
  const discountMealImageUrl = '';
  const discountMealBasePrice = 45.0;

  blocTest<ViewOffersCubit, ViewOffersState>(
    'emits [loading, loaded] with the offers and discounts the repository returns',
    setUp: () {
      when(() => getOffersFeed(any(), filter: any(named: 'filter'))).thenAnswer(
        (_) async => Result.success(
          PaginatedResult(
            items: [
              OfferFeedDiscountItem(
                discount,
                mealName: discountMealName,
                mealImageUrl: discountMealImageUrl,
                mealBasePrice: discountMealBasePrice,
              ),
              OfferFeedOfferItem(offer),
            ],
            hasMore: false,
          ),
        ),
      );
    },
    build: () => ViewOffersCubit(getOffersFeed),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ViewOffersState.loading(),
      ViewOffersState.loaded(
        items: [
          OfferFeedDiscountItem(
            discount,
            mealName: discountMealName,
            mealImageUrl: discountMealImageUrl,
            mealBasePrice: discountMealBasePrice,
          ),
          OfferFeedOfferItem(offer),
        ],
        hasMore: false,
        isLoadingMore: false,
      ),
    ],
  );

  blocTest<ViewOffersCubit, ViewOffersState>(
    'emits [loading, loaded(empty)] when the cook has no offers or discounts',
    setUp: () {
      when(() => getOffersFeed(any(), filter: any(named: 'filter'))).thenAnswer(
        (_) async => const Result.success(
          PaginatedResult<OfferFeedItemEntity>(items: [], hasMore: false),
        ),
      );
    },
    build: () => ViewOffersCubit(getOffersFeed),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ViewOffersState.loading(),
      const ViewOffersState.loaded(items: [], hasMore: false, isLoadingMore: false),
    ],
  );

  blocTest<ViewOffersCubit, ViewOffersState>(
    'emits [loading, error] when the repository call fails',
    setUp: () {
      when(() => getOffersFeed(any(), filter: any(named: 'filter'))).thenAnswer(
        (_) async => const Result.failure(ServerErrorException('backend unreachable')),
      );
    },
    build: () => ViewOffersCubit(getOffersFeed),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ViewOffersState.loading(),
      const ViewOffersState.error(ServerErrorException('backend unreachable')),
    ],
  );

  blocTest<ViewOffersCubit, ViewOffersState>(
    'switching filter resets to page one instead of appending',
    setUp: () {
      when(() => getOffersFeed(any(), filter: OfferFeedFilter.all)).thenAnswer(
        (_) async => Result.success(
          PaginatedResult(items: [OfferFeedOfferItem(offer)], hasMore: false),
        ),
      );
      when(() => getOffersFeed(any(), filter: OfferFeedFilter.active)).thenAnswer(
        (_) async => Result.success(
          PaginatedResult(
            items: [
              OfferFeedDiscountItem(
                discount,
                mealName: discountMealName,
                mealImageUrl: discountMealImageUrl,
                mealBasePrice: discountMealBasePrice,
              ),
            ],
            hasMore: false,
          ),
        ),
      );
    },
    build: () => ViewOffersCubit(getOffersFeed),
    act: (cubit) async {
      await cubit.load();
      await cubit.load(filter: OfferFeedFilter.active);
    },
    expect: () => [
      const ViewOffersState.loading(),
      ViewOffersState.loaded(items: [OfferFeedOfferItem(offer)], hasMore: false, isLoadingMore: false),
      const ViewOffersState.loading(),
      ViewOffersState.loaded(
        items: [
          OfferFeedDiscountItem(
            discount,
            mealName: discountMealName,
            mealImageUrl: discountMealImageUrl,
            mealBasePrice: discountMealBasePrice,
          ),
        ],
        hasMore: false,
        isLoadingMore: false,
      ),
    ],
  );
}
