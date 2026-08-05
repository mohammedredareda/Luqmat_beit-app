/// CK-12's two mutually-exclusive discount-expiry modes. Which single
/// field (`durationDays` XOR `usageLimit`) is authoritative on
/// [DiscountEntity] is enforced by the form validator, not the type —
/// same philosophy MealEntity's price/sellingOptions XOR already uses.
enum DiscountRestrictionMode { duration, usage }
