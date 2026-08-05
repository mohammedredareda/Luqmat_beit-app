import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../models/discount_model.dart';

/// In-memory stand-in for the real Dio-backed discounts endpoint — a
/// sibling of `FakeOffersRemoteDataSource`, not one merged datasource
/// (see that file's doc comment).
@lazySingleton
class FakeDiscountsRemoteDataSource {
  FakeDiscountsRemoteDataSource() : _discounts = List.of(_seed());

  final List<DiscountModel> _discounts;

  static List<DiscountModel> _seed() => [
        DiscountModel(
          id: 'discount-1',
          cookId: currentCookId,
          mealId: 'meal-1',
          mealName: 'كبسة دجاج منزلية',
          mealImageUrl: 'https://picsum.photos/seed/kabsa/200/200',
          mealBasePrice: 45,
          percentage: 20,
          mode: DiscountRestrictionMode.duration,
          durationDays: 5,
          isActive: true,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        DiscountModel(
          id: 'discount-2',
          cookId: currentCookId,
          mealId: 'meal-3',
          mealName: 'شوربة عدس',
          mealImageUrl: 'https://picsum.photos/seed/lentil/200/200',
          mealBasePrice: 15,
          percentage: 15,
          mode: DiscountRestrictionMode.usage,
          usageLimit: 20,
          usageCount: 8,
          isActive: true,
          createdAt: DateTime.now(),
        ),
        ..._generateBulkDiscounts(),
      ];

  /// Bulk-generated discounts (`discount-3` onward) so the merged offers+
  /// discounts feed is large enough to exercise cursor pagination — mixes
  /// duration- and usage-restricted, and already-expired vs. still-active,
  /// so the All/Active/Expired tabs each have something to show.
  static List<DiscountModel> _generateBulkDiscounts() {
    const mealNames = [
      'كبسة دجاج منزلية', 'فطائر لحم بالفرن', 'شوربة عدس', 'مسقعة باذنجان',
      'كنافة بالجبن',
    ];
    const imageSeeds = ['kabsa', 'fatayer', 'lentil', 'moussaka', 'kunafa'];

    final bulk = <DiscountModel>[];
    for (var i = 0; i < 22; i++) {
      final mealIndex = i % mealNames.length;
      final useDuration = i.isEven;
      final durationDays = useDuration ? 3 + (i % 8) * 2 : null;
      // Roughly a third already expired/exhausted, so the Expired tab has
      // content.
      final expired = i % 3 == 0;
      final createdAt = useDuration && expired
          ? DateTime.now().subtract(Duration(days: (durationDays ?? 0) + 4 + i))
          : DateTime.now().subtract(Duration(days: i % 5));

      bulk.add(
        DiscountModel(
          id: 'discount-${3 + i}',
          cookId: currentCookId,
          mealId: 'meal-${1 + mealIndex}',
          mealName: mealNames[mealIndex],
          mealImageUrl: 'https://picsum.photos/seed/${imageSeeds[mealIndex]}-$i/200/200',
          mealBasePrice: 15.0 + mealIndex * 10,
          percentage: 10 + (i % 4) * 5,
          mode: useDuration ? DiscountRestrictionMode.duration : DiscountRestrictionMode.usage,
          durationDays: durationDays,
          usageLimit: useDuration ? null : 10 + i % 15,
          usageCount: useDuration ? 0 : (expired ? 10 + i % 15 : i % 5),
          isActive: i % 6 != 0,
          createdAt: createdAt,
        ),
      );
    }
    return bulk;
  }

  Future<List<DiscountModel>> getMyDiscounts(String cookId) async => _discounts
      .where((d) => d.cookId == cookId && d.deletedAt == null)
      .toList(growable: false);

  Future<DiscountModel?> getDiscountById(String id) async {
    for (final discount in _discounts) {
      if (discount.id == id && discount.deletedAt == null) return discount;
    }
    return null;
  }

  Future<DiscountModel> createDiscount(DiscountModel discount) async {
    _discounts.add(discount);
    return discount;
  }

  Future<DiscountModel> updateDiscount(DiscountModel discount) async {
    final index = _discounts.indexWhere((d) => d.id == discount.id);
    if (index == -1) throw const NotFoundException('Discount not found');
    return _discounts[index] = discount;
  }

  /// CK-15 soft delete — never blocked, proceeds straight through.
  Future<void> deleteDiscount(String id) async {
    final index = _discounts.indexWhere((d) => d.id == id);
    if (index == -1) throw const NotFoundException('Discount not found');
    _discounts[index] = _discounts[index].copyWith(deletedAt: DateTime.now());
  }
}
