import 'package:bloc_test/bloc_test.dart';
import 'package:cook_app/features/offers_management/edit_offer/domain/usecases/get_offer.dart';
import 'package:cook_app/features/offers_management/edit_offer/domain/usecases/update_offer.dart';
import 'package:cook_app/features/offers_management/edit_offer/presentation/bloc/edit_offer_bloc.dart';
import 'package:cook_app/features/offers_management/edit_offer/presentation/bloc/edit_offer_event.dart';
import 'package:cook_app/features/offers_management/edit_offer/presentation/bloc/edit_offer_state.dart';
import 'package:cook_app/features/offers_management/shared/domain/offer_form_submission.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetOffer extends Mock implements GetOffer {}

class _MockUpdateOffer extends Mock implements UpdateOffer {}

void main() {
  late _MockGetOffer getOffer;
  late _MockUpdateOffer updateOffer;

  setUpAll(() {
    registerFallbackValue(const OfferFormSubmission(
      name: '',
      description: '',
      totalPrice: 0,
      durationDays: 0,
      isActive: true,
      includedMeals: [],
    ));
  });

  setUp(() {
    getOffer = _MockGetOffer();
    updateOffer = _MockUpdateOffer();
  });

  final seededOffer = OfferEntity(
    id: 'offer-1',
    cookId: 'cook-1',
    name: 'لمة العائلة',
    description: 'باقة عائلية',
    totalPrice: 120,
    durationDays: 14,
    isActive: true,
    createdAt: DateTime(2026),
    includedMeals: const [
      OfferMealEntity(
        mealId: 'meal-2',
        mealName: 'فطائر لحم بالفرن',
        mealImageUrl: 'https://picsum.photos/seed/fatayer/200/200',
        sellingOptionId: 'meal-2-opt-2',
        sellingOptionLabel: 'وسط',
        unitPrice: 25,
        quantity: 3,
      ),
    ],
  );

  blocTest<EditOfferBloc, EditOfferState>(
    'started with a successful GetOffer emits [loading, form(prefilled)]',
    setUp: () {
      when(() => getOffer('offer-1')).thenAnswer((_) async => Result.success(seededOffer));
    },
    build: () => EditOfferBloc(getOffer, updateOffer),
    act: (bloc) => bloc.add(const EditOfferEvent.started('offer-1')),
    expect: () => [
      const EditOfferState.loading(),
      isA<EditOfferForm>()
          .having((s) => s.data.name, 'name', 'لمة العائلة')
          .having((s) => s.data.includedMeals, 'includedMeals', hasLength(1)),
    ],
  );

  blocTest<EditOfferBloc, EditOfferState>(
    'started with a failing GetOffer emits [loading, loadError]',
    setUp: () {
      when(() => getOffer('offer-x'))
          .thenAnswer((_) async => const Result.failure(NotFoundException('not found')));
    },
    build: () => EditOfferBloc(getOffer, updateOffer),
    act: (bloc) => bloc.add(const EditOfferEvent.started('offer-x')),
    expect: () => [
      const EditOfferState.loading(),
      isA<EditOfferLoadError>(),
    ],
  );
}
