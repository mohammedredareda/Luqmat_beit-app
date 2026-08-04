import 'package:bloc_test/bloc_test.dart';
import 'package:cook_app/features/offers_management/view_offers/domain/usecases/get_offers_and_discounts.dart';
import 'package:cook_app/features/offers_management/view_offers/presentation/bloc/view_offers_cubit.dart';
import 'package:cook_app/features/offers_management/view_offers/presentation/bloc/view_offers_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetOffersAndDiscounts extends Mock implements GetOffersAndDiscounts {}

void main() {
  late _MockGetOffersAndDiscounts getOffersAndDiscounts;

  setUp(() {
    getOffersAndDiscounts = _MockGetOffersAndDiscounts();
  });

  final offer = OfferEntity(
    id: 'offer-1',
    cookId: 'cook-1',
    name: 'لمة العائلة',
    description: '',
    totalPrice: 120,
    durationDays: 14,
    isActive: true,
    createdAt: DateTime.now(),
  );

  final discount = DiscountEntity(
    id: 'discount-1',
    cookId: 'cook-1',
    mealId: 'meal-1',
    mealName: 'كبسة دجاج منزلية',
    mealImageUrl: '',
    mealBasePrice: 45,
    percentage: 20,
    mode: DiscountRestrictionMode.duration,
    durationDays: 5,
    isActive: true,
    createdAt: DateTime.now(),
  );

  blocTest<ViewOffersCubit, ViewOffersState>(
    'emits [loading, loaded] with the offers and discounts the repository returns',
    setUp: () {
      when(() => getOffersAndDiscounts(any())).thenAnswer(
        (_) async => Result.success((offers: [offer], discounts: [discount])),
      );
    },
    build: () => ViewOffersCubit(getOffersAndDiscounts),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ViewOffersState.loading(),
      ViewOffersState.loaded(offers: [offer], discounts: [discount]),
    ],
  );

  blocTest<ViewOffersCubit, ViewOffersState>(
    'emits [loading, loaded(empty)] when the cook has no offers or discounts',
    setUp: () {
      when(() => getOffersAndDiscounts(any())).thenAnswer(
        (_) async => const Result.success((offers: [], discounts: [])),
      );
    },
    build: () => ViewOffersCubit(getOffersAndDiscounts),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ViewOffersState.loading(),
      const ViewOffersState.loaded(offers: [], discounts: []),
    ],
  );

  blocTest<ViewOffersCubit, ViewOffersState>(
    'emits [loading, error] when the repository call fails',
    setUp: () {
      when(() => getOffersAndDiscounts(any())).thenAnswer(
        (_) async => const Result.failure(ServerErrorException('backend unreachable')),
      );
    },
    build: () => ViewOffersCubit(getOffersAndDiscounts),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ViewOffersState.loading(),
      const ViewOffersState.error(ServerErrorException('backend unreachable')),
    ],
  );
}
