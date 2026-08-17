/// Matches the change-phone-number mockup's input mask: exactly 9 local
/// digits starting with `9` (`9XX XXX XXX`), after the country code — the
/// leading `9` check catches a cook typing a habitual leading `0` (e.g.
/// "095555555"), which [toApiPhoneNumber] would otherwise turn into a
/// malformed double-zero number the server only rejects after a round
/// trip ("رقم الهاتف غير صالح").
bool isValidLocalPhoneNumber(String phoneNumber) {
  final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
  return digits.length == 9 && digits.startsWith('9');
}

/// Canonical stored/displayed form of a 9-digit local number, matching the
/// `+<country> XXX XXX XXX` grouping shown elsewhere in the profile (e.g.
/// the seeded `+966 50 123 4567`). Display only — see [toApiPhoneNumber]
/// for the value actually sent over the wire. Only called once validated.
String formatLocalPhoneNumber(String digits) =>
    '+963 ${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 9)}';

/// The wire format the real API's phone pattern accepts — confirmed
/// "10 digits starting with 09, or +9639 followed by 8 digits". Distinct
/// from [formatLocalPhoneNumber]'s spaced `+963 ...` display form, which
/// matches neither accepted pattern. Only called once validated.
String toApiPhoneNumber(String digits) => '0$digits';
