import 'package:core/core.dart';

/// The validated payload `CreateDiscount` consumes — built only after
/// `validateDiscountForm` reports no errors.
class DiscountFormSubmission {
  const DiscountFormSubmission({
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.mealBasePrice,
    required this.percentage,
    required this.mode,
    this.durationDays,
    this.usageLimit,
  });

  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final double mealBasePrice;
  final double percentage;
  final DiscountRestrictionMode mode;
  final int? durationDays;
  final int? usageLimit;
}

/// The validated payload `UpdateDiscount` consumes — the target meal is
/// read-only once a discount exists (decision 14), so unlike
/// [DiscountFormSubmission] this carries no meal fields at all.
class DiscountUpdateInput {
  const DiscountUpdateInput({
    required this.percentage,
    required this.mode,
    this.durationDays,
    this.usageLimit,
  });

  final double percentage;
  final DiscountRestrictionMode mode;
  final int? durationDays;
  final int? usageLimit;
}
