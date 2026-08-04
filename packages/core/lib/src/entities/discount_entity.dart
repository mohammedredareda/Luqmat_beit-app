import 'package:equatable/equatable.dart';

import 'discount_restriction_mode.dart';

/// CK-12–CK-15's percentage discount on a single meal, restricted either
/// by a fixed duration or a usage-count cap (never both — see [mode]).
class DiscountEntity extends Equatable {
  const DiscountEntity({
    required this.id,
    required this.cookId,
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.mealBasePrice,
    required this.percentage,
    required this.mode,
    required this.isActive,
    required this.createdAt,
    this.durationDays,
    this.usageLimit,
    this.usageCount = 0,
  });

  final String id;
  final String cookId;
  final String mealId;
  final String mealName;
  final String mealImageUrl;

  /// Snapshot of the meal's `displayPrice` as of the last save — what the
  /// list card's struck-through "before" price renders from, so the card
  /// never needs a live meal lookup.
  final double mealBasePrice;
  final double percentage;
  final DiscountRestrictionMode mode;
  final int? durationDays;
  final int? usageLimit;
  final int usageCount;
  final bool isActive;
  final DateTime createdAt;

  double get discountedPrice => mealBasePrice * (1 - percentage / 100);

  int? get remainingDays {
    if (mode != DiscountRestrictionMode.duration || durationDays == null) return null;
    final diff = createdAt.add(Duration(days: durationDays!)).difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  int? get remainingUsage {
    if (mode != DiscountRestrictionMode.usage || usageLimit == null) return null;
    final left = usageLimit! - usageCount;
    return left < 0 ? 0 : left;
  }

  @override
  List<Object?> get props => [
        id,
        cookId,
        mealId,
        mealName,
        mealImageUrl,
        mealBasePrice,
        percentage,
        mode,
        durationDays,
        usageLimit,
        usageCount,
        isActive,
        createdAt,
      ];
}
