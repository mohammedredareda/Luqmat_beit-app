/// Meal note ≤100, order note ≤150, rejection reason 15–150 — the
/// normalized note-length rules, kept in one place so both apps agree.
abstract final class NoteLengthValidator {
  static const int mealNoteMax = 100;
  static const int orderNoteMax = 150;
  static const int rejectionReasonMin = 15;
  static const int rejectionReasonMax = 150;

  static bool isMealNoteValid(String note) => note.length <= mealNoteMax;
  static bool isOrderNoteValid(String note) => note.length <= orderNoteMax;

  static bool isRejectionReasonValid(String reason) =>
      reason.length >= rejectionReasonMin && reason.length <= rejectionReasonMax;

  static String? rejectionReasonError(String reason) {
    if (isRejectionReasonValid(reason)) return null;
    return 'سبب الرفض يجب أن يكون بين $rejectionReasonMin و $rejectionReasonMax حرفاً';
  }
}
