import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_event.freezed.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.started() = _Started;
  const factory EditProfileEvent.retryLoadPressed() = _RetryLoadPressed;
  const factory EditProfileEvent.fullNameChanged(String value) = _FullNameChanged;
  const factory EditProfileEvent.bioChanged(String value) = _BioChanged;
  const factory EditProfileEvent.addressChanged(String value) = _AddressChanged;
  const factory EditProfileEvent.availabilityStartTimeChanged(String value) =
      _AvailabilityStartTimeChanged;
  const factory EditProfileEvent.availabilityEndTimeChanged(String value) =
      _AvailabilityEndTimeChanged;
  const factory EditProfileEvent.availabilityDayToggled(Weekday value) = _AvailabilityDayToggled;
  const factory EditProfileEvent.detectLocationPressed() = _DetectLocationPressed;
  const factory EditProfileEvent.avatarPicked(String path, int sizeBytes) = _AvatarPicked;
  const factory EditProfileEvent.submitPressed() = _SubmitPressed;
}
