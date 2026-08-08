import 'package:luqmat_beit_app/features/offers_management/shared/domain/offer_form_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a fully valid submission has no errors', () {
    final errors = validateOfferForm(
      name: 'لمة العائلة',
      totalPriceInput: '120',
      durationDaysInput: '14',
      includedMealIds: ['meal-1'],
    );

    expect(errors, isEmpty);
  });

  test('E1: zero meals is rejected', () {
    final errors = validateOfferForm(
      name: 'لمة العائلة',
      totalPriceInput: '120',
      durationDaysInput: '14',
      includedMealIds: [],
    );

    expect(errors['meals'], contains('zeroMeals'));
  });

  test('E2: non-positive total price is rejected', () {
    final errors = validateOfferForm(
      name: 'لمة العائلة',
      totalPriceInput: '0',
      durationDaysInput: '14',
      includedMealIds: ['meal-1'],
    );

    expect(errors['totalPrice'], contains('nonPositive'));
  });

  test('empty duration is required', () {
    final errors = validateOfferForm(
      name: 'لمة العائلة',
      totalPriceInput: '120',
      durationDaysInput: '',
      includedMealIds: ['meal-1'],
    );

    expect(errors['durationDays'], contains('required'));
  });

  test('empty name is required', () {
    final errors = validateOfferForm(
      name: '',
      totalPriceInput: '120',
      durationDaysInput: '14',
      includedMealIds: ['meal-1'],
    );

    expect(errors['name'], contains('required'));
  });
}
