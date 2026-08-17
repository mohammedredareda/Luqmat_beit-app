/// CK-12/CK-14's "نوع القيد"/"نوع الصلاحية" segmented control — per the
/// `create_discount_with_meal_selection` and `edit_discount` mockups, a
/// discount is constrained by exactly one of these at a time, never both.
enum DiscountRestrictionType { duration, usageCount }
