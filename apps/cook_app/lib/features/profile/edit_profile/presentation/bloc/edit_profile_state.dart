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

@freezed
class EditProfileFormData with _$EditProfileFormData {
  const factory EditProfileFormData({
    @Default('') String fullName,
    @Default('') String phoneNumber,
    @Default('') String bio,
    @Default('') String address,
    @Default(<Weekday>{}) Set<Weekday> availabilityDays,
    @Default(AvailabilityTime(hour: 9, minute: 0)) AvailabilityTime availabilityStartTime,
    @Default(AvailabilityTime(hour: 17, minute: 0)) AvailabilityTime availabilityEndTime,
    String? avatarPath,
    int? avatarSizeBytes,
    @Default(ProfileSubmitStatus.idle()) ProfileSubmitStatus submitStatus,
  }) = _EditProfileFormData;
}
