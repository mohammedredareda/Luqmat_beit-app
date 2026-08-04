/// CK-07's original-file image size cap (Rev. 2 / CR-17) — checked
/// against the picked file directly since there's no upload/compression
/// pipeline to compress the original for yet.
const maxMealImageBytes = 10 * 1024 * 1024;

/// One in-progress variation row, decoupled from the presentation layer's
/// Freezed `MealVariationDraft` so this stays a pure domain function.
typedef MealVariationRowInput = ({String label, String priceInput});

/// Implements CK-07's E1–E4 exception flows exactly. Returns a map of
/// field key -> error-code tokens (not translated strings — presentation
/// widgets map each token to an `AppLocalizations` message), matching
/// `ValidationException.fieldErrors`'s shape. An empty map means the form
/// is valid.
///
/// Keys used: `image`, `name`, `description`, `preorderHours`, `price`,
/// `variations`.
Map<String, List<String>> validateMealForm({
  required String name,
  required String description,
  required String? imagePath,
  required int? imageSizeBytes,
  required String preorderHoursInput,
  required bool sellWithVariations,
  required String priceInput,
  required List<MealVariationRowInput> variations,
}) {
  final errors = <String, List<String>>{};

  void addError(String field, String token) {
    (errors[field] ??= []).add(token);
  }

  // E1: required fields (image, name, description, duration) empty.
  if (imagePath == null || imagePath.isEmpty) addError('image', 'required');
  if (name.trim().isEmpty) addError('name', 'required');
  if (description.trim().isEmpty) addError('description', 'required');
  final preorderHours = int.tryParse(preorderHoursInput);
  if (preorderHoursInput.trim().isEmpty || preorderHours == null) {
    addError('preorderHours', 'required');
  }

  // E4: original image exceeds the 10 MB cap.
  if (imageSizeBytes != null && imageSizeBytes > maxMealImageBytes) {
    addError('image', 'imageTooLarge');
  }

  if (sellWithVariations) {
    // E2: variations switch enabled but zero variations added.
    if (variations.isEmpty) {
      addError('variations', 'zeroVariations');
    } else {
      // E3: any variation price zero/negative (or unparsable).
      for (final variation in variations) {
        final price = double.tryParse(variation.priceInput);
        if (price == null || price <= 0) {
          addError('variations', 'nonPositive');
          break;
        }
      }
    }
  } else {
    // E3: single price zero/negative (or unparsable).
    final price = double.tryParse(priceInput);
    if (price == null || price <= 0) addError('price', 'nonPositive');
  }

  return errors;
}
