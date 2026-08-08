import 'package:core/core.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import '../models/offer_meal_model.dart';
import '../models/offer_model.dart';

/// In-memory stand-in for the real Dio-backed offers endpoint — CK-11's
/// text treats offers and discounts as two separate backend tables, so
/// this is a sibling of `FakeDiscountsRemoteDataSource`, not one merged
/// datasource. Shared as one `@lazySingleton` instance across every
/// offers_management feature that touches offers.
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
          createdAt: DateTime.now(),
          expiryTime: DateTime.now().add(const Duration(days: 14)),
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
        ..._generateBulkOffers(),
      ];

  /// Bulk-generated offers (`offer-2` onward) so the merged offers+
  /// discounts feed is large enough to exercise cursor pagination — mixes
  /// already-expired and still-active durations so the All/Active/Expired
  /// tabs each have something to show.
  static List<OfferModel> _generateBulkOffers() {
    const names = [
      'وجبة الغداء السريعة', 'باقة العشاء الخفيف', 'سلة الإفطار المنزلي',
      'طقم الأسرة الكبير', 'باقة الأصدقاء', 'وجبة المكتب',
      'باقة نهاية الأسبوع', 'سلة الحلويات', 'باقة الشوربات', 'طقم المشاوي',
    ];
    final bulk = <OfferModel>[];
    for (var i = 0; i < 18; i++) {
      final durationDays = 3 + (i % 10) * 3;
      // Roughly a third already expired, so the Expired tab has content.
      final createdAt = i % 3 == 0
          ? DateTime.now().subtract(Duration(days: durationDays + 5 + i))
          : DateTime.now().subtract(Duration(days: i % 4));
      bulk.add(
        OfferModel(
          id: 'offer-${2 + i}',
          cookId: currentCookId,
          name: '${names[i % names.length]} ${(i ~/ names.length) + 1}',
          description: 'باقة مختارة بسعر مخفض لفترة محدودة.',
          totalPrice: 60.0 + (i % 8) * 10,
          durationDays: durationDays,
          createdAt: createdAt,
          expiryTime: createdAt.add(Duration(days: durationDays)),
          includedMeals: [
            OfferMealModel(
              mealId: 'meal-${1 + i % 5}',
              mealName: 'طبق رقم ${1 + i % 5}',
              mealImageUrl: 'https://picsum.photos/seed/offer-meal-$i/200/200',
              unitPrice: 20 + i % 5 * 5,
              quantity: 1 + i % 3,
            ),
          ],
        ),
      );
    }
    return bulk;
  }

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
