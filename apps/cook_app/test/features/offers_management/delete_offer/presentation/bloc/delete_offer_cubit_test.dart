import '../../../../../support/bloc_test_helper.dart';
import 'package:cook_app/features/offers_management/delete_offer/domain/usecases/delete_offer.dart';
import 'package:cook_app/features/offers_management/delete_offer/presentation/bloc/delete_offer_cubit.dart';
import 'package:cook_app/features/offers_management/delete_offer/presentation/bloc/delete_offer_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDeleteOffer extends Mock implements DeleteOffer {}

void main() {
  late _MockDeleteOffer deleteOffer;

  setUp(() {
    deleteOffer = _MockDeleteOffer();
  });

  blocTest<DeleteOfferCubit, DeleteOfferState>(
    'confirm to delete emits [submitting, success(offerId)]',
    setUp: () {
      when(() => deleteOffer('offer-1')).thenAnswer((_) async => const Result.success(null));
    },
    build: () => DeleteOfferCubit(deleteOffer),
    act: (cubit) => cubit.delete('offer-1'),
    expect: () => [
      const DeleteOfferState.submitting(),
      const DeleteOfferState.success('offer-1'),
    ],
  );

  blocTest<DeleteOfferCubit, DeleteOfferState>(
    'emits [submitting, failure] when the repository call fails',
    setUp: () {
      when(() => deleteOffer('offer-1')).thenAnswer(
        (_) async => const Result.failure(ServerErrorException('backend unreachable')),
      );
    },
    build: () => DeleteOfferCubit(deleteOffer),
    act: (cubit) => cubit.delete('offer-1'),
    expect: () => [
      const DeleteOfferState.submitting(),
      const DeleteOfferState.failure(ServerErrorException('backend unreachable')),
    ],
  );
}
