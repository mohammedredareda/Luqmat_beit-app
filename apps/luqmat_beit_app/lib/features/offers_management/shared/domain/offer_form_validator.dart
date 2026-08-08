/// Same 10 MB original-file cap as `meal_form_validator.dart`'s and
/// `profile_form_validator.dart`'s own copies — unlike those, the offer
/// photo itself is optional (CK-13's bundle offers fall back to a
/// placeholder header when unset), so only the size check applies here.
const maxOfferImageBytes = 10 * 1024 * 1024;

/// CK-13's E1 (zero meals) / E2 (non-positive price) plus a required,
/// positive duration. Keys: name, meals, totalPrice, durationDays, image.
Map<String, List<String>> validateOfferForm({
  required String name,
  required String totalPriceInput,
  required String durationDaysInput,
  required List<String> includedMealIds,
  int? imageSizeBytes,
}) {
  final errors = <String, List<String>>{};
  void addError(String field, String token) => (errors[field] ??= []).add(token);

  if (name.trim().isEmpty) addError('name', 'required');
  if (includedMealIds.isEmpty) addError('meals', 'zeroMeals'); // E1
  final price = double.tryParse(totalPriceInput);
  if (price == null || price <= 0) addError('totalPrice', 'nonPositive'); // E2
  final days = int.tryParse(durationDaysInput);
  if (durationDaysInput.trim().isEmpty || days == null || days <= 0) {
    addError('durationDays', 'required');
  }
  if (imageSizeBytes != null && imageSizeBytes > maxOfferImageBytes) {
    addError('image', 'imageTooLarge');
  }
  return errors;
}
