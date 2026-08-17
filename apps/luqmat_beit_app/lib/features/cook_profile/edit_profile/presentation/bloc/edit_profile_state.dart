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
/// (see [ProfileFormSubmission]). `selectedDays` is an independent
/// multi-select set (any combination, not a contiguous range) — the cook
/// can open, say, only Sat/Mon/Wed — expanded into ISO weekday numbers on
/// submit. `latitude`/`longitude` are null until the cook taps the
/// location-detect button — never required.
@freezed
class EditProfileFormData with _$EditProfileFormData {
  const factory EditProfileFormData({
    @Default('') String fullName,
    @Default('') String phoneNumber,
    @Default('') String bio,
    @Default('') String address,
    @Default('09:00') String availabilityStartTime,
    @Default('17:00') String availabilityEndTime,
    @Default(<Weekday>{}) Set<Weekday> selectedDays,
    double? latitude,
    double? longitude,
    @Default(false) bool isDetectingLocation,
    String? locationError,
    String? avatarPath,
    int? avatarSizeBytes,
    @Default(ProfileSubmitStatus.idle()) ProfileSubmitStatus submitStatus,
  }) = _EditProfileFormData;
}
