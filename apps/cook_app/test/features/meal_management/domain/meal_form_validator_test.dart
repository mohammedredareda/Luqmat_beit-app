import 'package:cook_app/features/meal_management/domain/meal_form_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, List<String>> validateValid({
    String name = 'كبسة دجاج',
    String description = 'وصف شهي',
    String? imagePath = '/tmp/image.png',
    int? imageSizeBytes = 1024,
    String preorderHoursInput = '2',
    bool sellWithVariations = false,
    String priceInput = '45',
    List<MealVariationRowInput> variations = const [],
  }) {
    return validateMealForm(
      name: name,
      description: description,
      imagePath: imagePath,
      imageSizeBytes: imageSizeBytes,
      preorderHoursInput: preorderHoursInput,
      sellWithVariations: sellWithVariations,
      priceInput: priceInput,
      variations: variations,
    );
  }

  test('a fully valid single-price submission has no errors', () {
    expect(validateValid(), isEmpty);
  });

  test('a fully valid variations submission has no errors', () {
    final errors = validateValid(
      sellWithVariations: true,
      variations: const [(label: 'صغير', priceInput: '20')],
    );
    expect(errors, isEmpty);
  });

  // E1: required fields (image, name, description, duration) empty.
  test('E1: empty name is required', () {
    expect(validateValid(name: '')['name'], contains('required'));
  });

  test('E1: empty description is required', () {
    expect(validateValid(description: '')['description'], contains('required'));
  });

  test('E1: missing image is required', () {
    expect(validateValid(imagePath: null)['image'], contains('required'));
  });

  test('E1: empty preorder hours is required', () {
    expect(validateValid(preorderHoursInput: '')['preorderHours'], contains('required'));
  });

  // E2: variations switch enabled but zero variations added.
  test('E2: variations toggle on with zero rows', () {
    final errors = validateValid(sellWithVariations: true, variations: const []);
    expect(errors['variations'], contains('zeroVariations'));
  });

  // E3: price/variation price zero or negative.
  test('E3: single price zero is rejected', () {
    expect(validateValid(priceInput: '0')['price'], contains('nonPositive'));
  });

  test('E3: single price negative is rejected', () {
    expect(validateValid(priceInput: '-5')['price'], contains('nonPositive'));
  });

  test('E3: a variation price of zero is rejected', () {
    final errors = validateValid(
      sellWithVariations: true,
      variations: const [(label: 'صغير', priceInput: '0')],
    );
    expect(errors['variations'], contains('nonPositive'));
  });

  // E4: original image exceeds the 10 MB cap.
  test('E4: image exceeding 10 MB is rejected', () {
    final errors = validateValid(imageSizeBytes: maxMealImageBytes + 1);
    expect(errors['image'], contains('imageTooLarge'));
  });

  test('E4: image exactly at the 10 MB cap is accepted', () {
    final errors = validateValid(imageSizeBytes: maxMealImageBytes);
    expect(errors['image'], isNull);
  });
}
