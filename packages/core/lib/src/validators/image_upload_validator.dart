/// Original file ≤10MB — the caller must compress before upload; this
/// validator only enforces the ceiling.
abstract final class ImageUploadValidator {
  static const int maxBytes = 10 * 1024 * 1024;

  static bool isValid(int sizeInBytes) => sizeInBytes <= maxBytes;

  static String? errorMessage(int sizeInBytes) {
    if (isValid(sizeInBytes)) return null;
    return 'حجم الصورة يجب ألا يتجاوز 10 ميجابايت';
  }
}
