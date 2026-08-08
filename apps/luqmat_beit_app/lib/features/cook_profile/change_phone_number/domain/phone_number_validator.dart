/// Matches the change-phone-number mockup's input mask: exactly 9 local
/// digits (`9XX XXX XXX`), after the country code.
bool isValidLocalPhoneNumber(String phoneNumber) {
  final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
  return digits.length == 9;
}

/// Canonical stored/displayed form of a 9-digit local number, matching the
/// `+<country> XXX XXX XXX` grouping shown elsewhere in the profile (e.g.
/// the seeded `+966 50 123 4567`). Only called once validated.
String formatLocalPhoneNumber(String digits) =>
    '+963 ${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 9)}';
