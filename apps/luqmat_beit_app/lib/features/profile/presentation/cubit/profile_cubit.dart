import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfile, this._updateProfile) : super(const ProfileState.initial());

  final GetProfile _getProfile;
  final UpdateProfile _updateProfile;

  Future<void> load() async {
    emit(const ProfileState.loading());
    final result = await _getProfile();
    result.fold(
      (profile) => emit(ProfileState.loaded(profile)),
      (exception) => emit(ProfileState.failure(exception)),
    );
  }

  void toggleEdit() {
    final current = state;
    if (current is ProfileLoaded) {
      emit(ProfileState.loaded(current.profile, isEditing: !current.isEditing));
    }
  }

  void cancelEdit() {
    final current = state;
    if (current is ProfileLoaded) {
      emit(ProfileState.loaded(current.profile, isEditing: false));
    }
  }

  Future<void> save({required String name, required String address}) async {
    final current = state;
    if (current is! ProfileLoaded) return;

    emit(ProfileState.loaded(current.profile, isEditing: true, isSaving: true));
    final result = await _updateProfile(name: name, address: address);
    result.fold(
      (profile) => emit(ProfileState.loaded(profile)),
      (exception) => emit(ProfileState.loaded(current.profile, isEditing: true)),
    );
  }
}
