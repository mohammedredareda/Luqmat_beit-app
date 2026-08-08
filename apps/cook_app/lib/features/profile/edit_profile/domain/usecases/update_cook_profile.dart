import 'package:core/core.dart';

import '../../../domain/cook_profile_details.dart';
import '../../../domain/profile_form_submission.dart';
import '../repositories/edit_profile_repository.dart';

class UpdateCookProfile {
  UpdateCookProfile(this._repository);

  final EditProfileRepository _repository;

  Future<Result<CookProfileDetails>> call(String cookId, ProfileFormSubmission submission) =>
      _repository.updateProfile(cookId, submission);
}
