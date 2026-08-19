import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_profile.dart';
import 'profile_state.dart';

/// Single fetch-and-display flow (per this repo's Bloc-vs-Cubit
/// convention) — editing lives in its own `EditProfileBloc`/route now,
/// matching the cook module's `view_profile`/`edit_profile` split.
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfile) : super(const ProfileState.initial());

  final GetProfile _getProfile;

  Future<void> load() async {
    emit(const ProfileState.loading());
    final result = await _getProfile();
    if (isClosed) return;
    result.fold(
      (profile) => emit(ProfileState.loaded(profile)),
      (exception) => emit(ProfileState.failure(exception)),
    );
  }
}
