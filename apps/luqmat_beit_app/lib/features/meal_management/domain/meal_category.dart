/// CK-07's fixed 5-category catalog cooks assign meals to. Carries no
/// Arabic text itself — presentation widgets map each value to its
/// localized label — so this stays reusable if a future customer-facing
/// filter needs the same catalog.
enum MealCategory {
  mainDishes,
  pastries,
  desserts,
  appetizers,
  beverages;

  String get id => switch (this) {
        MealCategory.mainDishes => 'main_dishes',
        MealCategory.pastries => 'pastries',
        MealCategory.desserts => 'desserts',
        MealCategory.appetizers => 'appetizers',
        MealCategory.beverages => 'beverages',
      };

  static MealCategory? fromId(String id) {
    for (final category in MealCategory.values) {
      if (category.id == id) return category;
    }
    return null;
  }
}
