/// One included-meal row as entered in the create/edit offer form, before
/// it's turned into a persisted [OfferFormSubmission].
class OfferMealInput {
  const OfferMealInput({
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.unitPrice,
    required this.quantity,
    this.sellingOptionId,
    this.sellingOptionLabel,
  });

  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final String? sellingOptionId;
  final String? sellingOptionLabel;
  final double unitPrice;
  final int quantity;
}

/// The validated payload both `CreateOffer` and `UpdateOffer` usecases
/// consume — built only after `validateOfferForm` reports no errors.
class OfferFormSubmission {
  const OfferFormSubmission({
    required this.name,
    required this.description,
    required this.totalPrice,
    required this.durationDays,
    required this.isActive,
    required this.includedMeals,
    this.imagePath,
  });

  final String name;
  final String description;
  final double totalPrice;
  final int durationDays;
  final bool isActive;
  final String? imagePath;
  final List<OfferMealInput> includedMeals;
}
