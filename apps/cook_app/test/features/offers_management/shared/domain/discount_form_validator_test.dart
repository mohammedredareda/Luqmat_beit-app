import 'package:cook_app/features/offers_management/shared/domain/discount_form_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a fully valid submission with only duration has no errors', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      durationDaysInput: '5',
      usageLimitInput: '',
    );

    expect(errors, isEmpty);
  });

  test('a fully valid submission with duration and a usage limit has no errors', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      durationDaysInput: '5',
      usageLimitInput: '20',
    );

    expect(errors, isEmpty);
  });

  test('E1: percentage of 0 is out of range', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '0',
      durationDaysInput: '5',
      usageLimitInput: '',
    );

    expect(errors['percentage'], contains('outOfRange'));
  });

  test('E1: percentage of 101 is out of range', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '101',
      durationDaysInput: '5',
      usageLimitInput: '',
    );

    expect(errors['percentage'], contains('outOfRange'));
  });

  test('E2: no meal selected is required', () {
    final errors = validateDiscountForm(
      mealId: null,
      percentageInput: '20',
      durationDaysInput: '5',
      usageLimitInput: '',
    );

    expect(errors['meal'], contains('required'));
  });

  test('duration is required even when a usage limit is provided', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      durationDaysInput: '',
      usageLimitInput: '20',
    );

    expect(errors['duration'], contains('required'));
  });

  test('a non-positive usage limit is invalid', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      durationDaysInput: '5',
      usageLimitInput: '0',
    );

    expect(errors['usageLimit'], contains('invalid'));
  });
}
