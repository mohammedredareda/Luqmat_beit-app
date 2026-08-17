/// Mockup `_3`'s 60s duration cap, passed straight to `image_picker`'s
/// `maxDuration` parameter at pick time so it's enforced before a video is
/// even selected — it never reaches this validator as an invalid state to
/// catch.
const shortMaxVideoDuration = Duration(seconds: 60);

const maxShortDescriptionLength = 300;

/// Implements mockup `_3`'s Create Short form rules. Returns a map of field
/// key -> error-code tokens (not translated strings — presentation widgets
/// map each token to an `AppLocalizations` message), matching
/// `ValidationException.fieldErrors`'s shape. An empty map means the form is
/// valid.
///
/// Keys used: `video`, `description`. Linking a meal is optional (mockup
/// `_3`'s toggle), so there is no `meal` key.
Map<String, List<String>> validateShortForm({
  required String? videoPath,
  required String description,
}) {
  final errors = <String, List<String>>{};

  void addError(String field, String token) {
    (errors[field] ??= []).add(token);
  }

  if (videoPath == null || videoPath.isEmpty) addError('video', 'required');
  if (description.trim().isEmpty) {
    addError('description', 'required');
  } else if (description.length > maxShortDescriptionLength) {
    addError('description', 'tooLong');
  }

  return errors;
}
