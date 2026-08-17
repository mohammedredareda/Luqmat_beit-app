import 'package:luqmat_beit_app/features/offers_management/shared/domain/discount_form_validator.dart';
import 'package:luqmat_beit_app/features/offers_management/shared/domain/discount_restriction_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a fully valid duration-mode submission has no errors', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      durationDaysInput: '5',
      usageLimitInput: '',
      restrictionType: DiscountRestrictionType.duration,
    );

    expect(errors, isEmpty);
  });

  test('a fully valid usage-count-mode submission has no errors', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      durationDaysInput: '',
      usageLimitInput: '20',
      restrictionType: DiscountRestrictionType.usageCount,
    );

    expect(errors, isEmpty);
  });

  test('E1: percentage of 0 is out of range', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '0',
      durationDaysInput: '5',
      usageLimitInput: '',
      restrictionType: DiscountRestrictionType.duration,
    );

    expect(errors['percentage'], contains('outOfRange'));
  });

  test('E1: percentage of 101 is out of range', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '101',
      durationDaysInput: '5',
      usageLimitInput: '',
      restrictionType: DiscountRestrictionType.duration,
    );

    expect(errors['percentage'], contains('outOfRange'));
  });

  test('E2: no meal selected is required', () {
    final errors = validateDiscountForm(
      mealId: null,
      percentageInput: '20',
      durationDaysInput: '5',
      usageLimitInput: '',
      restrictionType: DiscountRestrictionType.duration,
    );

    expect(errors['meal'], contains('required'));
  });

  test('duration is required in duration mode', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      durationDaysInput: '',
      usageLimitInput: '',
      restrictionType: DiscountRestrictionType.duration,
    );

    expect(errors['duration'], contains('required'));
  });

  test('usage limit is required in usage-count mode', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      durationDaysInput: '',
      usageLimitInput: '0',
      restrictionType: DiscountRestrictionType.usageCount,
    );

    expect(errors['usageLimit'], contains('required'));
  });

  test('duration mode ignores a leftover invalid usage-limit value', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      durationDaysInput: '5',
      usageLimitInput: '-3',
      restrictionType: DiscountRestrictionType.duration,
    );

    expect(errors, isEmpty);
  });

  test('usage-count mode ignores a leftover empty duration value', () {
    final errors = validateDiscountForm(
      mealId: 'meal-1',
      percentageInput: '20',
      durationDaysInput: '',
      usageLimitInput: '20',
      restrictionType: DiscountRestrictionType.usageCount,
    );

    expect(errors, isEmpty);
  });
}
