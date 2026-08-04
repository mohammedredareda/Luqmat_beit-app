import 'package:core/core.dart';

import '../../../domain/profile_form_submission.dart';

abstract class EditProfileRepository {
  Future<Result<CookProfileEntity>> getProfile(String cookId);

  Future<Result<CookProfileEntity>> updateProfile(
    String cookId,
    ProfileFormSubmission submission,
  );
}
