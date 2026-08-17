import '../../../../../support/bloc_test_helper.dart';
import 'package:luqmat_beit_app/features/offers_management/view_offers/domain/entities/offer_feed_filter.dart';
import 'package:luqmat_beit_app/features/offers_management/view_offers/domain/entities/offer_feed_item_entity.dart';
import 'package:luqmat_beit_app/features/offers_management/view_offers/domain/usecases/get_offers_feed.dart';
import 'package:luqmat_beit_app/features/offers_management/view_offers/presentation/bloc/view_offers_cubit.dart';
import 'package:luqmat_beit_app/features/offers_management/view_offers/presentation/bloc/view_offers_state.dart';
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

  final now = DateTime.now();

  final offerItem = OfferFeedOfferItem(
    rawId: 'offer-1',
    title: 'لمة العائلة',
    description: '',
    createdAt: now,
    expiryTime: now.add(const Duration(days: 14)),
  );

  final discountItem = OfferFeedDiscountItem(
    rawId: 'discount-1',
    title: 'خصم 20% على كبسة دجاج منزلية',
    description: '',
    createdAt: now,
    expiryTime: now.add(const Duration(days: 5)),
  );

  blocTest<ViewOffersCubit, ViewOffersState>(
    'emits [loading, loaded] with the offers and discounts the repository returns',
    setUp: () {
      when(() => getOffersFeed(any(), filter: any(named: 'filter'))).thenAnswer(
        (_) async => Result.success(
          PaginatedResult(items: [discountItem, offerItem], hasMore: false),
        ),
      );
    },
    build: () => ViewOffersCubit(getOffersFeed),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ViewOffersState.loading(),
      ViewOffersState.loaded(
        items: [discountItem, offerItem],
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
          PaginatedResult(items: [offerItem], hasMore: false),
        ),
      );
      when(() => getOffersFeed(any(), filter: OfferFeedFilter.active)).thenAnswer(
        (_) async => Result.success(
          PaginatedResult(items: [discountItem], hasMore: false),
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
      ViewOffersState.loaded(items: [offerItem], hasMore: false, isLoadingMore: false),
      const ViewOffersState.loading(),
      ViewOffersState.loaded(items: [discountItem], hasMore: false, isLoadingMore: false),
    ],
  );
}
