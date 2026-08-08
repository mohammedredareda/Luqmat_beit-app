/// CK-27's new-password rule: same complexity bar as registration (CK-01)
/// — minimum 8 characters, upper, lower, digit, special character. Returns
/// error-code tokens (not translated strings), matching
/// `profile_form_validator.dart`'s shape. An empty list means valid.
List<String> validateNewPassword(String password) {
  final errors = <String>[];
  if (password.length < 8) errors.add('tooShort');
  if (!password.contains(RegExp('[A-Z]'))) errors.add('missingUppercase');
  if (!password.contains(RegExp('[a-z]'))) errors.add('missingLowercase');
  if (!password.contains(RegExp(r'[0-9]'))) errors.add('missingDigit');
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=~`\[\];/\\]'))) {
    errors.add('missingSymbol');
  }
  return errors;
}

/// 0-4 password strength score used by the change-password screen's
/// strength meter — mirrors the `change_password` mockup's scoring: one
/// point each for length >= 8, an uppercase letter, a digit, and a symbol.
enum PasswordStrength { empty, weak, medium, good, veryStrong }

PasswordStrength scorePasswordStrength(String password) {
  if (password.isEmpty) return PasswordStrength.empty;

  var score = 0;
  if (password.length >= 8) score++;
  if (password.contains(RegExp('[A-Z]'))) score++;
  if (password.contains(RegExp(r'[0-9]'))) score++;
  if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=~`\[\];/\\]'))) score++;

  return switch (score) {
    0 || 1 => PasswordStrength.weak,
    2 => PasswordStrength.medium,
    3 => PasswordStrength.good,
    _ => PasswordStrength.veryStrong,
  };
}
