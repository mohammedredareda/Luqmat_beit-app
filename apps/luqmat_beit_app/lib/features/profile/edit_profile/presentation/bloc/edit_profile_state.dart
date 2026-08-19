import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile_submit_status.dart';

part 'edit_profile_state.freezed.dart';

/// Two independent sources of UI-distinct branching justify Bloc here (not
/// a Cubit): the load phase (`loading`/`loadError`/`form`) and the submit
/// phase (`idle`/`submitting`/`validationFailure`/`success`/`failure`) —
/// same reasoning the cook module's `EditProfileState` documents.
@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.loading() = EditProfileLoading;
  const factory EditProfileState.loadError(AppException exception) = EditProfileLoadError;
  const factory EditProfileState.form(EditProfileFormData data) = EditProfileForm;
}

/// `latitude`/`longitude` are null until the customer taps the
/// location-detect button — never required.
@freezed
class EditProfileFormData with _$EditProfileFormData {
  const factory EditProfileFormData({
    @Default('') String name,
    @Default('') String address,
    double? latitude,
    double? longitude,
    @Default(false) bool isDetectingLocation,
    String? locationError,
    String? avatarPath,
    int? avatarSizeBytes,
    @Default(ProfileSubmitStatus.idle()) ProfileSubmitStatus submitStatus,
  }) = _EditProfileFormData;
}
