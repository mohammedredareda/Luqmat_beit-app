import 'package:flutter_test/flutter_test.dart';

import 'package:core/core.dart';

void main() {
  group('MealEntity.computeIsActive', () {
    const meal = MealEntity(
      id: 'm1',
      cookId: 'c1',
      cookName: 'أم محمد',
      name: 'مسخن',
      description: 'مسخن فلسطيني أصلي',
      imageUrl: 'https://example.com/m.jpg',
      sellingOptions: [],
    );

    test('is active within window, not stopped, cook not paused', () {
      expect(
        meal.computeIsActive(
          withinAvailabilityWindow: true,
          cookIsSellingPaused: false,
        ),
        isTrue,
      );
    });

    test('is inactive when soft-deleted regardless of other flags', () {
      final deleted = MealEntity(
        id: meal.id,
        cookId: meal.cookId,
        cookName: meal.cookName,
        name: meal.name,
        description: meal.description,
        imageUrl: meal.imageUrl,
        sellingOptions: meal.sellingOptions,
        deletedAt: DateTime.now(),
      );
      expect(
        deleted.computeIsActive(
          withinAvailabilityWindow: true,
          cookIsSellingPaused: false,
        ),
        isFalse,
      );
    });
  });
}
