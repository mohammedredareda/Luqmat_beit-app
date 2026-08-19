import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_event.freezed.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.started() = _Started;
  const factory EditProfileEvent.retryLoadPressed() = _RetryLoadPressed;
  const factory EditProfileEvent.nameChanged(String value) = _NameChanged;
  const factory EditProfileEvent.addressChanged(String value) = _AddressChanged;
  const factory EditProfileEvent.detectLocationPressed() = _DetectLocationPressed;
  const factory EditProfileEvent.avatarPicked(String path, int sizeBytes) = _AvatarPicked;
  const factory EditProfileEvent.submitPressed() = _SubmitPressed;
}
