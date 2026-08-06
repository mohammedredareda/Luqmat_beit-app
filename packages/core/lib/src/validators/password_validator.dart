/// 8+ chars, upper, lower, number, special char.
abstract final class PasswordValidator {
  static bool isValid(String password) {
    if (password.length < 8) return false;
    final hasUpper = password.contains(RegExp(r'[A-Z]'));
    final hasLower = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'\d'));
    final hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_\-]'));
    return hasUpper && hasLower && hasDigit && hasSpecial;
  }

  static String? errorMessage(String password) {
    if (isValid(password)) return null;
    return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل وتحتوي على حرف كبير وصغير ورقم ورمز خاص';
  }
}
