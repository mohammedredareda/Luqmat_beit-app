import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../models/offer_meal_model.dart';
import '../models/offer_model.dart';

/// In-memory stand-in for the real Dio-backed offers endpoint — CK-11's
/// text treats offers and discounts as two separate backend tables, so
/// this is a sibling of `FakeDiscountsRemoteDataSource`, not one merged
/// datasource. Shared as one `@lazySingleton` instance across every
/// offers_management feature that touches offers.
@lazySingleton
class FakeOffersRemoteDataSource {
  FakeOffersRemoteDataSource() : _offers = List.of(_seed());

  final List<OfferModel> _offers;

  static List<OfferModel> _seed() => [
        OfferModel(
          id: 'offer-1',
          cookId: currentCookId,
          name: 'لمة العائلة',
          description: 'باقة عائلية تجمع أطباقاً مختارة بسعر مخفض',
          totalPrice: 120,
          durationDays: 14,
          isActive: true,
          createdAt: DateTime.now(),
          includedMeals: const [
            OfferMealModel(
              mealId: 'meal-2',
              mealName: 'فطائر لحم بالفرن',
              mealImageUrl: 'https://picsum.photos/seed/fatayer/200/200',
              sellingOptionId: 'meal-2-opt-2',
              sellingOptionLabel: 'وسط',
              unitPrice: 25,
              quantity: 3,
            ),
            OfferMealModel(
              mealId: 'meal-4',
              mealName: 'مسقعة باذنجان',
              mealImageUrl: 'https://picsum.photos/seed/moussaka/200/200',
              unitPrice: 25,
              quantity: 2,
            ),
            OfferMealModel(
              mealId: 'meal-5',
              mealName: 'كنافة بالجبن',
              mealImageUrl: 'https://picsum.photos/seed/kunafa/200/200',
              unitPrice: 20,
              quantity: 1,
            ),
          ],
        ),
      ];

  Future<List<OfferModel>> getMyOffers(String cookId) async =>
      _offers.where((o) => o.cookId == cookId && o.deletedAt == null).toList(growable: false);

  Future<OfferModel?> getOfferById(String id) async {
    for (final offer in _offers) {
      if (offer.id == id && offer.deletedAt == null) return offer;
    }
    return null;
  }

  Future<OfferModel> createOffer(OfferModel offer) async {
    _offers.add(offer);
    return offer;
  }

  Future<OfferModel> updateOffer(OfferModel offer) async {
    final index = _offers.indexWhere((o) => o.id == offer.id);
    if (index == -1) throw const NotFoundException('Offer not found');
    return _offers[index] = offer;
  }

  /// CK-15 soft delete — never blocked (unlike meal delete's deferred
  /// order-check), proceeds straight through.
  Future<void> deleteOffer(String id) async {
    final index = _offers.indexWhere((o) => o.id == id);
    if (index == -1) throw const NotFoundException('Offer not found');
    _offers[index] = _offers[index].copyWith(deletedAt: DateTime.now());
  }
}
