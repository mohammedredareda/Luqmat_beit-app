import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_profile.dart';
import '../../../domain/usecases/update_profile.dart';
import '../../domain/profile_form_validator.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';
import 'profile_submit_status.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(this._getProfile, this._updateProfile, this._detectCurrentLocation)
      : super(const EditProfileState.loading()) {
    on<EditProfileEvent>((event, emit) => event.when(
          started: () => _load(emit),
          retryLoadPressed: () => _load(emit),
          nameChanged: (value) async => _updateForm(emit, (data) => data.copyWith(name: value)),
          addressChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(address: value)),
          detectLocationPressed: () => _detectLocation(emit),
          avatarPicked: (path, sizeBytes) async => _updateForm(
                emit,
                (data) => data.copyWith(avatarPath: path, avatarSizeBytes: sizeBytes),
              ),
          submitPressed: () => _submit(emit),
        ));
  }

  final GetProfile _getProfile;
  final UpdateProfile _updateProfile;
  final DetectCurrentLocation _detectCurrentLocation;

  void _updateForm(
    Emitter<EditProfileState> emit,
    EditProfileFormData Function(EditProfileFormData data) transform,
  ) {
    final current = state;
    if (current is EditProfileForm) emit(EditProfileState.form(transform(current.data)));
  }

  Future<void> _load(Emitter<EditProfileState> emit) async {
    emit(const EditProfileState.loading());
    final result = await _getProfile();
    result.fold(
      (profile) => emit(EditProfileState.form(EditProfileFormData(
        name: profile.name,
        address: profile.address,
        latitude: profile.latitude,
        longitude: profile.longitude,
        avatarPath: profile.avatarUrl,
      ))),
      (exception) => emit(EditProfileState.loadError(exception)),
    );
  }

  /// Mirrors the cook module's `_detectLocation` call pattern — never
  /// touches `address`, since it's independently editable and shouldn't be
  /// silently overwritten.
  Future<void> _detectLocation(Emitter<EditProfileState> emit) async {
    final current = state;
    if (current is! EditProfileForm) return;
    _updateForm(emit, (data) => data.copyWith(isDetectingLocation: true, locationError: null));

    final result = await _detectCurrentLocation();
    result.fold(
      (location) => _updateForm(
        emit,
        (data) => data.copyWith(
          isDetectingLocation: false,
          latitude: location.latitude,
          longitude: location.longitude,
        ),
      ),
      (exception) => _updateForm(
        emit,
        (data) => data.copyWith(isDetectingLocation: false, locationError: exception.message),
      ),
    );
  }

  Future<void> _submit(Emitter<EditProfileState> emit) async {
    final formState = state;
    if (formState is! EditProfileForm) return;
    final data = formState.data;

    final errors = validateProfileForm(
      name: data.name,
      address: data.address,
      avatarSizeBytes: data.avatarSizeBytes,
    );

    if (errors.isNotEmpty) {
      emit(EditProfileState.form(
        data.copyWith(submitStatus: ProfileSubmitStatus.validationFailure(errors)),
      ));
      return;
    }

    emit(EditProfileState.form(data.copyWith(submitStatus: const ProfileSubmitStatus.submitting())));

    final result = await _updateProfile(
      name: data.name,
      address: data.address,
      latitude: data.latitude,
      longitude: data.longitude,
      avatarPath: data.avatarPath,
    );
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
