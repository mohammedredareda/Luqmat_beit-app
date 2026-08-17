/// The validated payload `CreateShort` consumes — built only after
/// `validateShortForm` reports no errors. Mirrors `DiscountFormSubmission`'s
/// shape. Linking a meal is optional (mockup `_3`'s toggle): [mealId]/
/// [mealName]/[mealImageUrl] are `null` together when no meal was linked.
class ShortFormSubmission {
  const ShortFormSubmission({
    required this.videoPath,
    required this.description,
    this.mealId,
    this.mealName,
    this.mealImageUrl,
  });

  final String videoPath;
  final String description;
  final String? mealId;
  final String? mealName;
  final String? mealImageUrl;
}
