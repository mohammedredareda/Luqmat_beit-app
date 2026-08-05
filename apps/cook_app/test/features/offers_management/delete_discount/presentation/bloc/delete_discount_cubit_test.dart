import 'package:bloc_test/bloc_test.dart';
import 'package:cook_app/features/offers_management/delete_discount/domain/usecases/delete_discount.dart';
import 'package:cook_app/features/offers_management/delete_discount/presentation/bloc/delete_discount_cubit.dart';
import 'package:cook_app/features/offers_management/delete_discount/presentation/bloc/delete_discount_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDeleteDiscount extends Mock implements DeleteDiscount {}

void main() {
  late _MockDeleteDiscount deleteDiscount;

  setUp(() {
    deleteDiscount = _MockDeleteDiscount();
  });

  blocTest<DeleteDiscountCubit, DeleteDiscountState>(
    'confirm to delete emits [submitting, success(discountId)]',
    setUp: () {
      when(() => deleteDiscount('discount-1'))
          .thenAnswer((_) async => const Result.success(null));
    },
    build: () => DeleteDiscountCubit(deleteDiscount),
    act: (cubit) => cubit.delete('discount-1'),
    expect: () => [
      const DeleteDiscountState.submitting(),
      const DeleteDiscountState.success('discount-1'),
    ],
  );

  blocTest<DeleteDiscountCubit, DeleteDiscountState>(
    'emits [submitting, failure] when the repository call fails',
    setUp: () {
      when(() => deleteDiscount('discount-1')).thenAnswer(
        (_) async => const Result.failure(ServerErrorException('backend unreachable')),
      );
    },
    build: () => DeleteDiscountCubit(deleteDiscount),
    act: (cubit) => cubit.delete('discount-1'),
    expect: () => [
      const DeleteDiscountState.submitting(),
      const DeleteDiscountState.failure(ServerErrorException('backend unreachable')),
    ],
  );
}
