import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/profile_form_submission.dart';
import '../repositories/edit_profile_repository.dart';

@injectable
class UpdateCookProfile {
  UpdateCookProfile(this._repository);

  final EditProfileRepository _repository;

  Future<Result<CookProfileEntity>> call(String cookId, ProfileFormSubmission submission) =>
      _repository.updateProfile(cookId, submission);
}
