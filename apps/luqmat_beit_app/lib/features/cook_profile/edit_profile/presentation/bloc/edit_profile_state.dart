import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile_submit_status.dart';

part 'edit_profile_state.freezed.dart';

/// Two independent sources of UI-distinct branching justify Bloc here (not
/// a Cubit, despite CK-20's own text having only one exception flow): the
/// load phase (`loading`/`loadError`/`form`) and the submit phase
/// (`idle`/`submitting`/`validationFailure`/`success`/`failure`) — same
/// reasoning `EditMealState`/`EditOfferState` already document.
@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.loading() = EditProfileLoading;
  const factory EditProfileState.loadError(AppException exception) = EditProfileLoadError;
  const factory EditProfileState.form(EditProfileFormData data) = EditProfileForm;
}

/// `availabilityStartTime`/`availabilityEndTime` are `"HH:mm"` 24-hour
/// strings — combined into one `availabilityTime` window field on submit
/// (see [ProfileFormSubmission]), never a per-weekday schedule.
@freezed
class EditProfileFormData with _$EditProfileFormData {
  const factory EditProfileFormData({
    @Default('') String fullName,
    @Default('') String phoneNumber,
    @Default('') String bio,
    @Default('') String address,
    @Default('09:00') String availabilityStartTime,
    @Default('17:00') String availabilityEndTime,
    String? avatarPath,
    int? avatarSizeBytes,
    @Default(ProfileSubmitStatus.idle()) ProfileSubmitStatus submitStatus,
  }) = _EditProfileFormData;
}
