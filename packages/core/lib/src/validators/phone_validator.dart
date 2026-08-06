/// Exactly 10 digits, "09" prefix, no +/-, no country selector — a literal
/// transcription of the normalized phone rule.
abstract final class PhoneValidator {
  static final _pattern = RegExp(r'^09\d{8}$');

  static bool isValid(String phone) => _pattern.hasMatch(phone);

  static String? errorMessage(String phone) {
    if (isValid(phone)) return null;
    return 'رقم الهاتف يجب أن يتكون من 10 أرقام ويبدأ بـ 09';
  }
}
