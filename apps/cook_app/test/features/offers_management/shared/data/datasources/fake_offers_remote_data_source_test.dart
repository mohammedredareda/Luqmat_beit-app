import 'package:cook_app/shared/current_cook_id.dart';
import 'package:cook_app/features/offers_management/shared/data/datasources/fake_offers_remote_data_source.dart';
import 'package:cook_app/features/offers_management/shared/data/models/offer_model.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeOffersRemoteDataSource dataSource;

  setUp(() {
    dataSource = FakeOffersRemoteDataSource();
  });

  OfferModel buildOffer({String id = 'offer-new'}) => OfferModel(
        id: id,
        cookId: currentCookId,
        name: 'عرض جديد',
        description: 'وصف',
        totalPrice: 50,
        durationDays: 7,
        isActive: true,
        createdAt: DateTime.now(),
      );

  test('createOffer appends and is retrievable via getMyOffers and getOfferById', () async {
    final created = await dataSource.createOffer(buildOffer());

    final myOffers = await dataSource.getMyOffers(currentCookId);
    expect(myOffers.any((o) => o.id == created.id), isTrue);

    final byId = await dataSource.getOfferById(created.id);
    expect(byId, isNotNull);
  });

  test('updateOffer replaces the offer in place', () async {
    final created = await dataSource.createOffer(buildOffer());
    final updated = created.copyWith(name: 'اسم محدث');

    final result = await dataSource.updateOffer(updated);

    expect(result.name, 'اسم محدث');
    final byId = await dataSource.getOfferById(created.id);
    expect(byId!.name, 'اسم محدث');
  });

  test('updateOffer on an unknown id throws NotFoundException', () async {
    expect(
      () => dataSource.updateOffer(buildOffer(id: 'does-not-exist')),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('deleteOffer on an unknown id throws NotFoundException', () async {
    expect(() => dataSource.deleteOffer('does-not-exist'), throwsA(isA<NotFoundException>()));
  });

  test('deleteOffer soft-deletes: excluded from getMyOffers and getOfferById', () async {
    final created = await dataSource.createOffer(buildOffer());

    await dataSource.deleteOffer(created.id);

    final myOffers = await dataSource.getMyOffers(currentCookId);
    expect(myOffers.any((o) => o.id == created.id), isFalse);
    expect(await dataSource.getOfferById(created.id), isNull);
  });
}
