/// Same original-file image size cap the cook module's edit-profile form
/// uses (`cook_profile/domain/profile_form_validator.dart`), defined
/// locally per this codebase's existing per-epic convention.
const maxProfileImageBytes = 10 * 1024 * 1024;

/// Field-key -> error-code token map (not translated strings — presentation
/// widgets map each token to an `AppLocalizations` message), matching
/// `ValidationException.fieldErrors`'s shape. An empty map means the form
/// is valid. Keys used: `name`, `address`, `avatar`.
Map<String, List<String>> validateProfileForm({
  required String name,
  required String address,
  required int? avatarSizeBytes,
}) {
  final errors = <String, List<String>>{};

  void addError(String field, String token) {
    (errors[field] ??= []).add(token);
  }

  if (name.trim().isEmpty) addError('name', 'required');
  if (address.trim().isEmpty) addError('address', 'required');

  if (avatarSizeBytes != null && avatarSizeBytes > maxProfileImageBytes) {
    addError('avatar', 'imageTooLarge');
  }

  return errors;
}
