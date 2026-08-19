import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/customer_profile_entity.dart';

part 'profile_submit_status.freezed.dart';

/// The submit outcome sub-state embedded in `EditProfileFormData` — mirrors
/// the cook module's `ProfileSubmitStatus` role.
@freezed
class ProfileSubmitStatus with _$ProfileSubmitStatus {
  const factory ProfileSubmitStatus.idle() = ProfileSubmitIdle;
  const factory ProfileSubmitStatus.submitting() = ProfileSubmitSubmitting;
  const factory ProfileSubmitStatus.validationFailure(
    Map<String, List<String>> fieldErrors,
  ) = ProfileSubmitValidationFailure;
  const factory ProfileSubmitStatus.success(CustomerProfileEntity profile) = ProfileSubmitSuccess;
  const factory ProfileSubmitStatus.failure(AppException exception) = ProfileSubmitFailure;
}
