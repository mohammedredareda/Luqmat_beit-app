/// The validated payload `CreateDiscount` consumes — built only after
/// `validateDiscountForm` reports no errors. Discounts always target
/// exactly one meal. [DiscountRestrictionType] (duration vs. usage-count)
/// is a UI-only concept the cook picks between — the wire contract still
/// requires [discountDurationDays] on every request, so the calling Bloc
/// fills it with a long fallback when the cook picked usage-count mode
/// instead of leaving it unset.
class DiscountFormSubmission {
  const DiscountFormSubmission({
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.mealBasePrice,
    required this.discountPercentage,
    required this.discountDurationDays,
    this.usageNumberLimit,
  });

  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final double mealBasePrice;
  final double discountPercentage;
  final int discountDurationDays;
  final int? usageNumberLimit;
}

/// The validated payload `UpdateDiscount` consumes — the target meal is
/// read-only once a discount exists (decision 14), so unlike
/// [DiscountFormSubmission] this carries no meal fields at all.
class DiscountUpdateInput {
  const DiscountUpdateInput({
    required this.discountPercentage,
    required this.discountDurationDays,
    this.usageNumberLimit,
  });

  final double discountPercentage;
  final int discountDurationDays;
  final int? usageNumberLimit;
}
