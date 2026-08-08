import '../../../../../support/bloc_test_helper.dart';
import 'package:cook_app/features/offers_management/create_offer/domain/usecases/create_offer.dart';
import 'package:cook_app/features/offers_management/create_offer/presentation/bloc/create_offer_bloc.dart';
import 'package:cook_app/features/offers_management/create_offer/presentation/bloc/create_offer_event.dart';
import 'package:cook_app/features/offers_management/create_offer/presentation/bloc/create_offer_state.dart';
import 'package:cook_app/features/offers_management/shared/domain/offer_form_submission.dart';
import 'package:cook_app/features/offers_management/shared/presentation/bloc/offer_meal_draft.dart';
import 'package:cook_app/features/offers_management/shared/presentation/bloc/offer_submit_status.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCreateOffer extends Mock implements CreateOffer {}

void main() {
  late _MockCreateOffer createOffer;

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
    createOffer = _MockCreateOffer();
  });

  const meal2 = MealEntity(
    id: 'meal-2',
    cookId: 'cook-1',
    cookName: 'Cook One',
    name: 'فطائر لحم بالفرن',
    description: 'عجينة منزلية',
    imageUrl: 'https://picsum.photos/seed/fatayer/200/200',
    sellingOptions: [
      SellingOptionEntity(id: 'meal-2-opt-1', label: 'صغير', price: 15),
      SellingOptionEntity(id: 'meal-2-opt-2', label: 'وسط', price: 25),
    ],
  );

  const validState = CreateOfferState(
    name: 'لمة العائلة',
    totalPriceInput: '80',
    durationDaysInput: '10',
    includedMeals: [
      OfferMealDraft(
        mealId: 'meal-1',
        mealName: 'كبسة دجاج منزلية',
        mealImageUrl: 'https://picsum.photos/seed/kabsa/200/200',
        unitPrice: 45,
        quantity: 1,
      ),
    ],
  );

  final createdOffer = OfferEntity(
    id: 'offer-new',
    cookId: 'cook-1',
    name: 'لمة العائلة',
    description: '',
    totalPrice: 80,
    durationDays: 10,
    createdAt: DateTime(2026),
    expiryTime: DateTime(2026, 1, 11),
  );

  blocTest<CreateOfferBloc, CreateOfferState>(
    'submitPressed with zero meals emits validationFailure and never calls the usecase',
    build: () => CreateOfferBloc(createOffer),
    act: (bloc) => bloc.add(const CreateOfferEvent.submitPressed()),
    expect: () => [
      isA<CreateOfferState>().having(
        (s) => s.submitStatus,
        'submitStatus',
        isA<OfferSubmitValidationFailure>(),
      ),
    ],
    verify: (_) => verifyNever(() => createOffer(any())),
  );

  blocTest<CreateOfferBloc, CreateOfferState>(
    'mealAdded with a variations meal and a chosen option builds the expected OfferMealDraft',
    build: () => CreateOfferBloc(createOffer),
    act: (bloc) => bloc.add(
      const CreateOfferEvent.mealAdded(meal2, SellingOptionEntity(id: 'meal-2-opt-2', label: 'وسط', price: 25)),
    ),
    expect: () => [
      isA<CreateOfferState>().having(
        (s) => s.includedMeals,
        'includedMeals',
        [
          const OfferMealDraft(
            mealId: 'meal-2',
            mealName: 'فطائر لحم بالفرن',
            mealImageUrl: 'https://picsum.photos/seed/fatayer/200/200',
            sellingOptionId: 'meal-2-opt-2',
            sellingOptionLabel: 'وسط',
            unitPrice: 25,
            quantity: 1,
          ),
        ],
      ),
    ],
  );

  blocTest<CreateOfferBloc, CreateOfferState>(
    'duplicate mealAdded for an already-included meal is a no-op',
    build: () => CreateOfferBloc(createOffer),
    seed: () => validState,
    act: (bloc) => bloc.add(const CreateOfferEvent.mealAdded(
      MealEntity(
        id: 'meal-1',
        cookId: 'cook-1',
        cookName: 'Cook One',
        name: 'كبسة دجاج منزلية',
        description: '',
        imageUrl: '',
        sellingOptions: [],
        singlePrice: 45,
      ),
      null,
    )),
    expect: () => [],
  );

  blocTest<CreateOfferBloc, CreateOfferState>(
    'submitPressed with a fully valid form emits [submitting, success]',
    setUp: () {
      when(() => createOffer(any())).thenAnswer((_) async => Result.success(createdOffer));
    },
    build: () => CreateOfferBloc(createOffer),
    seed: () => validState,
    act: (bloc) => bloc.add(const CreateOfferEvent.submitPressed()),
    expect: () => [
      validState.copyWith(submitStatus: const OfferSubmitStatus.submitting()),
      validState.copyWith(submitStatus: OfferSubmitStatus.success(createdOffer)),
    ],
  );
}
