/// The validated payload `CreateDiscount` consumes — built only after
/// `validateDiscountForm` reports no errors. Discounts always target
/// exactly one meal. [DiscountRestrictionType] (duration vs. usage-count)
/// is a UI-only concept the cook picks between. [discountDurationDays] is
/// non-nullable here purely because the domain model (`DiscountModel`)
/// needs *some* placeholder value internally when usage-count mode is
/// chosen — the calling Bloc fills it with a long fallback rather than
/// leaving it unset. That placeholder never reaches the wire as a real
/// duration though: duration and usage-count are mutually exclusive
/// server-side (confirmed live — sending both as non-null 400s), so
/// `DiscountModel.toApiRequestFields` nulls out `discount_duration`
/// whenever [usageNumberLimit] is set, regardless of this field's value.
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
