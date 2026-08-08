/// CK-07/CU-29's shared original-file image size cap (Rev. 2 / CR-17),
/// applied here to the profile photo too — defined locally per this
/// codebase's existing per-epic convention (see `meal_form_validator.dart`'s
/// own copy of the same constant/value).
const maxProfileImageBytes = 10 * 1024 * 1024;

int? _parseMinutes(String time24) {
  final parts = time24.split(':');
  if (parts.length != 2) return null;
  final hour = int.tryParse(parts[0]);
  final minute = int.tryParse(parts[1]);
  if (hour == null || minute == null) return null;
  return hour * 60 + minute;
}

/// Implements CK-20's E1 (required-field-cleared) exception flow, extended
/// with an availability-window rule now that it's a single `"HH:mm"`-`"HH:mm"`
/// pair rather than free text. Returns a map of field key -> error-code
/// tokens (not translated strings — presentation widgets map each token to
/// an `AppLocalizations` message), matching `ValidationException.fieldErrors`'s
/// shape. An empty map means the form is valid.
///
/// Keys used: `fullName`, `address`, `availabilityHours`, `avatar`. `bio` is
/// intentionally not validated — no rule requires it, unlike the other
/// fields. Phone number is no longer editable here — it moved to Settings'
/// Change Phone Number flow, which has its own validation.
Map<String, List<String>> validateProfileForm({
  required String fullName,
  required String address,
  required String availabilityStartTime,
  required String availabilityEndTime,
  required int? avatarSizeBytes,
}) {
  final errors = <String, List<String>>{};

  void addError(String field, String token) {
    (errors[field] ??= []).add(token);
  }

  if (fullName.trim().isEmpty) addError('fullName', 'required');
  if (address.trim().isEmpty) addError('address', 'required');

  final startMinutes = _parseMinutes(availabilityStartTime);
  final endMinutes = _parseMinutes(availabilityEndTime);
  if (startMinutes == null || endMinutes == null || endMinutes <= startMinutes) {
    addError('availabilityHours', 'invalidRange');
  }

  if (avatarSizeBytes != null && avatarSizeBytes > maxProfileImageBytes) {
    addError('avatar', 'imageTooLarge');
  }

  return errors;
}
