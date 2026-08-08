import 'package:core/core.dart';

import '../../../domain/cook_profile_details.dart';
import '../../../domain/profile_form_submission.dart';

abstract class EditProfileRepository {
  Future<Result<CookProfileDetails>> getProfile(String cookId);

  Future<Result<CookProfileDetails>> updateProfile(
    String cookId,
    ProfileFormSubmission submission,
  );
}
