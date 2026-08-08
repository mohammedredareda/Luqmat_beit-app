/// CK-12's E1 (percentage not in (0, 100]) / E2 (no meal selected) / a
/// required, positive duration; usage limit is optional but must be
/// positive when provided. Keys: meal, percentage, duration, usageLimit.
Map<String, List<String>> validateDiscountForm({
  required String? mealId,
  required String percentageInput,
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
  final days = int.tryParse(durationDaysInput);
  if (durationDaysInput.trim().isEmpty || days == null || days <= 0) {
    addError('duration', 'required');
  }
  if (usageLimitInput.trim().isNotEmpty) {
    final usage = int.tryParse(usageLimitInput);
    if (usage == null || usage <= 0) addError('usageLimit', 'invalid');
  }
  return errors;
}
