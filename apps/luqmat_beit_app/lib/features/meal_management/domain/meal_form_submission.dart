/// One variation row (size/label + price) as entered in the create/edit
/// meal form, before it's turned into a persisted [MealFormSubmission].
class MealVariationInput {
  const MealVariationInput({required this.label, required this.price});

  final String label;
  final double price;
}

/// The validated payload both `CreateMeal` and `UpdateMeal` usecases
/// consume — built only after `validateMealForm` reports no errors, so by
/// construction either [price] is set and [sellingOptions] is empty, or
/// the reverse (CK-07's single-price-XOR-variations rule).
class MealFormSubmission {
  const MealFormSubmission({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.categoryIds,
    required this.preorderHours,
    this.price,
    this.sellingOptions = const [],
  });

  final String name;
  final String description;
  final String imagePath;
  final List<String> categoryIds;
  final int preorderHours;
  final double? price;
  final List<MealVariationInput> sellingOptions;
}
