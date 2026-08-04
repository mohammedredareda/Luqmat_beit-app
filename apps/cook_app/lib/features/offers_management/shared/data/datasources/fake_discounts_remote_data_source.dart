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
      ];

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
