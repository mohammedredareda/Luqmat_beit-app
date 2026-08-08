/// The validated payload `CreateDiscount` consumes — built only after
/// `validateDiscountForm` reports no errors. Discounts always target
/// exactly one meal; there is no restriction-mode concept.
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
