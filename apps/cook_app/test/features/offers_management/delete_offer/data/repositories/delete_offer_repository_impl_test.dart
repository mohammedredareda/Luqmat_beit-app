import 'package:cook_app/shared/current_cook_id.dart';
import 'package:cook_app/features/offers_management/delete_offer/data/repositories/delete_offer_repository_impl.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_offers_remote_data_source.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeOffersRemoteDataSource dataSource;
  late DeleteOfferRepositoryImpl repository;

  setUp(() {
    dataSource = FakeOffersRemoteDataSource();
    repository = DeleteOfferRepositoryImpl(dataSource);
  });

  test('deleteOffer on a seeded id returns Result.success and excludes it from getMyOffers',
      () async {
    final result = await repository.deleteOffer('offer-1');

    expect(result, isA<Success<void>>());
    final myOffers = await dataSource.getMyOffers(currentCookId);
    expect(myOffers.any((o) => o.id == 'offer-1'), isFalse);
  });

  test('deleteOffer on an unknown id returns Result.failure(NotFoundException)', () async {
    final result = await repository.deleteOffer('does-not-exist');

    expect(result, isA<Failure<void>>());
    expect((result as Failure<void>).exception, isA<NotFoundException>());
  });
}
