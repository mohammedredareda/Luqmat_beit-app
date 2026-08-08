import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/cook_profile_details.dart';

part 'profile_submit_status.freezed.dart';

/// The submit outcome sub-state embedded in `EditProfileFormData` — mirrors
/// `MealSubmitStatus`'s role in `meal_management`. Local to `edit_profile`
/// (only one consumer, unlike `MealSubmitStatus` which needed promoting to
/// the `meal_management` epic root for 3 sibling features).
@freezed
class ProfileSubmitStatus with _$ProfileSubmitStatus {
  const factory ProfileSubmitStatus.idle() = ProfileSubmitIdle;
  const factory ProfileSubmitStatus.submitting() = ProfileSubmitSubmitting;
  const factory ProfileSubmitStatus.validationFailure(
    Map<String, List<String>> fieldErrors,
  ) = ProfileSubmitValidationFailure;
  const factory ProfileSubmitStatus.success(CookProfileDetails profile) = ProfileSubmitSuccess;
  const factory ProfileSubmitStatus.failure(AppException exception) = ProfileSubmitFailure;
}
