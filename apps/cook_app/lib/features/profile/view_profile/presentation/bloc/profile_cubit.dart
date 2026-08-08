import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../domain/usecases/get_cook_profile.dart';
import 'profile_state.dart';

/// CK-21 View Profile with Stats — a single fetch-and-display flow, same
/// Cubit-over-Bloc reasoning as `ViewMenuCubit`/`ViewOffersCubit`.
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getCookProfile) : super(const ProfileState.initial());

  final GetCookProfile _getCookProfile;

  Future<void> loadProfile() async {
    emit(const ProfileState.loading());
    final result = await _getCookProfile(currentCookId);
    result.fold(
      (profile) => emit(ProfileState.loaded(profile)),
      (exception) => emit(ProfileState.error(exception)),
    );
  }
}
