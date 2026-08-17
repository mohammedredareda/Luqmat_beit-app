import 'discount_restriction_type.dart';

/// CK-12's E1 (percentage not in (0, 100]) / E2 (no meal selected) / a
/// required, positive value for whichever [restrictionType] is active —
/// duration and usage-count are mutually exclusive (never both required at
/// once), so only the active one is validated. Keys: meal, percentage,
/// duration, usageLimit.
Map<String, List<String>> validateDiscountForm({
  required String? mealId,
  required String percentageInput,
  required String durationDaysInput,
  required String usageLimitInput,
  required DiscountRestrictionType restrictionType,
}) {
  final errors = <String, List<String>>{};
  void addError(String field, String token) => (errors[field] ??= []).add(token);

  if (mealId == null || mealId.isEmpty) addError('meal', 'required'); // E2
  final percentage = double.tryParse(percentageInput);
  if (percentage == null || percentage <= 0 || percentage > 100) {
    addError('percentage', 'outOfRange'); // E1
  }
  switch (restrictionType) {
    case DiscountRestrictionType.duration:
      final days = int.tryParse(durationDaysInput);
      if (durationDaysInput.trim().isEmpty || days == null || days <= 0) {
        addError('duration', 'required');
      }
    case DiscountRestrictionType.usageCount:
      final usage = int.tryParse(usageLimitInput);
      if (usageLimitInput.trim().isEmpty || usage == null || usage <= 0) {
        addError('usageLimit', 'required');
      }
  }
  return errors;
}
