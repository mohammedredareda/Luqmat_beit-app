import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../../domain/profile_form_submission.dart';
import '../../../domain/profile_form_validator.dart';
import '../../domain/usecases/get_cook_profile.dart';
import '../../domain/usecases/update_cook_profile.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';
import 'profile_submit_status.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(this._getCookProfile, this._updateCookProfile)
      : super(const EditProfileState.loading()) {
    on<EditProfileEvent>((event, emit) => event.when(
          started: () => _load(emit),
          retryLoadPressed: () => _load(emit),
          fullNameChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(fullName: value)),
          bioChanged: (value) async => _updateForm(emit, (data) => data.copyWith(bio: value)),
          addressChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(address: value)),
          availabilityDayToggled: (day) async => _updateForm(emit, (data) {
                final days = Set<Weekday>.of(data.availabilityDays);
                if (!days.remove(day)) days.add(day);
                return data.copyWith(availabilityDays: days);
              }),
          availabilityStartTimeChanged: (time) async =>
              _updateForm(emit, (data) => data.copyWith(availabilityStartTime: time)),
          availabilityEndTimeChanged: (time) async =>
              _updateForm(emit, (data) => data.copyWith(availabilityEndTime: time)),
          avatarPicked: (path, sizeBytes) async => _updateForm(
                emit,
                (data) => data.copyWith(avatarPath: path, avatarSizeBytes: sizeBytes),
              ),
          submitPressed: () => _submit(emit),
        ));
  }

  final GetCookProfile _getCookProfile;
  final UpdateCookProfile _updateCookProfile;

  void _updateForm(
    Emitter<EditProfileState> emit,
    EditProfileFormData Function(EditProfileFormData data) transform,
  ) {
    final current = state;
    if (current is EditProfileForm) emit(EditProfileState.form(transform(current.data)));
  }

  Future<void> _load(Emitter<EditProfileState> emit) async {
    emit(const EditProfileState.loading());
    final result = await _getCookProfile(currentCookId);
    result.fold(
      (profile) => emit(EditProfileState.form(EditProfileFormData(
        fullName: profile.fullName,
        phoneNumber: profile.phoneNumber,
        bio: profile.bio,
        address: profile.address,
        availabilityDays: profile.availabilityDays,
        availabilityStartTime: profile.availabilityStartTime,
        availabilityEndTime: profile.availabilityEndTime,
        avatarPath: profile.avatarUrl,
      ))),
      (exception) => emit(EditProfileState.loadError(exception)),
    );
  }

  Future<void> _submit(Emitter<EditProfileState> emit) async {
    final formState = state;
    if (formState is! EditProfileForm) return;
    final data = formState.data;

    final errors = validateProfileForm(
      fullName: data.fullName,
      address: data.address,
      availabilityDays: data.availabilityDays,
      availabilityStartTime: data.availabilityStartTime,
      availabilityEndTime: data.availabilityEndTime,
      avatarSizeBytes: data.avatarSizeBytes,
    );

    if (errors.isNotEmpty) {
      emit(EditProfileState.form(
        data.copyWith(submitStatus: ProfileSubmitStatus.validationFailure(errors)),
      ));
      return;
    }

    emit(EditProfileState.form(data.copyWith(submitStatus: const ProfileSubmitStatus.submitting())));

    final submission = ProfileFormSubmission(
      fullName: data.fullName,
      phoneNumber: data.phoneNumber,
      bio: data.bio,
      address: data.address,
      availabilityDays: data.availabilityDays,
      availabilityStartTime: data.availabilityStartTime,
      availabilityEndTime: data.availabilityEndTime,
      avatarPath: data.avatarPath,
    );

    final result = await _updateCookProfile(currentCookId, submission);
    result.fold(
      (profile) => emit(
        EditProfileState.form(data.copyWith(submitStatus: ProfileSubmitStatus.success(profile))),
      ),
      (exception) => emit(
        EditProfileState.form(data.copyWith(submitStatus: ProfileSubmitStatus.failure(exception))),
      ),
    );
  }
}
