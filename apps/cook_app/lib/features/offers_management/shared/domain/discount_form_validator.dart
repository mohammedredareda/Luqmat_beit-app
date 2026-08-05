import 'package:core/core.dart';

/// CK-12's E1 (percentage not in (0, 100]) / E2 (no meal selected) / E3
/// (the active restriction mode's own field left empty/non-positive).
/// Keys: meal, percentage, restriction.
Map<String, List<String>> validateDiscountForm({
  required String? mealId,
  required String percentageInput,
  required DiscountRestrictionMode mode,
  required String durationDaysInput,
  required String usageLimitInput,
}) {
  final errors = <String, List<String>>{};
  void addError(String field, String token) => (errors[field] ??= []).add(token);

  if (mealId == null || mealId.isEmpty) addError('meal', 'required'); // E2
  final percentage = double.tryParse(percentageInput);
  if (percentage == null || percentage <= 0 || percentage > 100) {
    addError('percentage', 'outOfRange'); // E1
  }
  switch (mode) {
    case DiscountRestrictionMode.duration:
      final days = int.tryParse(durationDaysInput);
      if (durationDaysInput.trim().isEmpty || days == null || days <= 0) {
        addError('restriction', 'required'); // E3
      }
    case DiscountRestrictionMode.usage:
      final usage = int.tryParse(usageLimitInput);
      if (usageLimitInput.trim().isEmpty || usage == null || usage <= 0) {
        addError('restriction', 'required'); // E3
      }
  }
  return errors;
}
