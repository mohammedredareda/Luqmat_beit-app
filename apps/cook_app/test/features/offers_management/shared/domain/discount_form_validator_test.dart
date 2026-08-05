import 'package:cook_app/features/offers_management/shared/domain/discount_form_validator.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a fully valid duration-mode submission has no errors', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      mode: DiscountRestrictionMode.duration,
      durationDaysInput: '5',
      usageLimitInput: '',
    );

    expect(errors, isEmpty);
  });

  test('a fully valid usage-mode submission has no errors', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      mode: DiscountRestrictionMode.usage,
      durationDaysInput: '',
      usageLimitInput: '20',
    );

    expect(errors, isEmpty);
  });

  test('E1: percentage of 0 is out of range', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '0',
      mode: DiscountRestrictionMode.duration,
      durationDaysInput: '5',
      usageLimitInput: '',
    );

    expect(errors['percentage'], contains('outOfRange'));
  });

  test('E1: percentage of 101 is out of range', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '101',
      mode: DiscountRestrictionMode.duration,
      durationDaysInput: '5',
      usageLimitInput: '',
    );

    expect(errors['percentage'], contains('outOfRange'));
  });

  test('E2: no meal selected is required', () {
    final errors = validateDiscountForm(
      mealId: null,
      percentageInput: '20',
      mode: DiscountRestrictionMode.duration,
      durationDaysInput: '5',
      usageLimitInput: '',
    );

    expect(errors['meal'], contains('required'));
  });

  test('E3: duration mode with empty days is required', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      mode: DiscountRestrictionMode.duration,
      durationDaysInput: '',
      usageLimitInput: '',
    );

    expect(errors['restriction'], contains('required'));
  });

  test('E3: usage mode with empty limit is required', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      mode: DiscountRestrictionMode.usage,
      durationDaysInput: '',
      usageLimitInput: '',
    );

    expect(errors['restriction'], contains('required'));
  });
}
