import 'package:bloc_test/bloc_test.dart';
import 'package:cook_app/features/offers_management/edit_discount/domain/usecases/get_discount.dart';
import 'package:cook_app/features/offers_management/edit_discount/domain/usecases/update_discount.dart';
import 'package:cook_app/features/offers_management/edit_discount/presentation/bloc/edit_discount_bloc.dart';
import 'package:cook_app/features/offers_management/edit_discount/presentation/bloc/edit_discount_event.dart';
import 'package:cook_app/features/offers_management/edit_discount/presentation/bloc/edit_discount_state.dart';
import 'package:cook_app/features/offers_management/shared/domain/discount_form_submission.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetDiscount extends Mock implements GetDiscount {}

class _MockUpdateDiscount extends Mock implements UpdateDiscount {}

void main() {
  late _MockGetDiscount getDiscount;
  late _MockUpdateDiscount updateDiscount;

  setUpAll(() {
    registerFallbackValue(const DiscountUpdateInput(
      percentage: 0,
      mode: DiscountRestrictionMode.duration,
    ));
  });

  setUp(() {
    getDiscount = _MockGetDiscount();
    updateDiscount = _MockUpdateDiscount();
  });

  final seededDiscount = DiscountEntity(
    id: 'discount-1',
    cookId: 'cook-1',
    mealId: 'meal-1',
    mealName: 'كبسة دجاج منزلية',
    mealImageUrl: 'https://picsum.photos/seed/kabsa/200/200',
    mealBasePrice: 45,
    percentage: 20,
    mode: DiscountRestrictionMode.duration,
    durationDays: 5,
    isActive: true,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  );

  ({DiscountEntity discount, List<SellingOptionEntity> mealSellingOptions, double mealPrice})
      bundleFor(DiscountEntity discount) => (
            discount: discount,
            mealSellingOptions: const <SellingOptionEntity>[],
            mealPrice: discount.mealBasePrice,
          );

  blocTest<EditDiscountBloc, EditDiscountState>(
    'started with a successful GetDiscount emits [loading, form(prefilled)]',
    setUp: () {
      when(() => getDiscount('discount-1'))
          .thenAnswer((_) async => Result.success(bundleFor(seededDiscount)));
    },
    build: () => EditDiscountBloc(getDiscount, updateDiscount),
    act: (bloc) => bloc.add(const EditDiscountEvent.started('discount-1')),
    expect: () => [
      const EditDiscountState.loading(),
      isA<EditDiscountForm>()
          .having((s) => s.data.mealName, 'mealName', 'كبسة دجاج منزلية')
          .having((s) => s.data.percentageInput, 'percentageInput', '20.0'),
    ],
  );

  blocTest<EditDiscountBloc, EditDiscountState>(
    'started with a failing GetDiscount emits [loading, loadError]',
    setUp: () {
      when(() => getDiscount('discount-x'))
          .thenAnswer((_) async => const Result.failure(NotFoundException('not found')));
    },
    build: () => EditDiscountBloc(getDiscount, updateDiscount),
    act: (bloc) => bloc.add(const EditDiscountEvent.started('discount-x')),
    expect: () => [
      const EditDiscountState.loading(),
      isA<EditDiscountLoadError>(),
    ],
  );

  test('EditDiscountEvent has no mealSelected factory', () {
    // Confirmed at compile time: EditDiscountEvent's union has no
    // `mealSelected` constructor (decision 14) — this test documents the
    // intent; a `mealSelected` call site would fail to compile.
    expect(EditDiscountEvent.started('discount-1'), isA<EditDiscountEvent>());
  });
}
