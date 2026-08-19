import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_chef_profile.dart';
import '../../domain/usecases/toggle_follow_chef.dart';
import 'chef_profile_state.dart';

class ChefProfileCubit extends Cubit<ChefProfileState> {
  ChefProfileCubit(this._getChefProfile, this._toggleFollowChef)
      : super(const ChefProfileState.initial());

  final GetChefProfile _getChefProfile;
  final ToggleFollowChef _toggleFollowChef;

  Future<void> loadProfile(String chefId) async {
    emit(const ChefProfileState.loading());
    final result = await _getChefProfile(chefId);
    if (isClosed) return;
    result.fold(
      (profile) => emit(ChefProfileState.loaded(profile)),
      (exception) => emit(ChefProfileState.failure(exception)),
    );
  }

  void search(String query) {
    final current = state;
    if (current is ChefProfileLoaded) {
      emit(current.copyWith(searchQuery: query));
    }
  }

  void selectTag(String? tag) {
    final current = state;
    if (current is ChefProfileLoaded) {
      emit(current.copyWith(selectedTag: tag));
    }
  }

  Future<void> toggleFollow() async {
    final current = state;
    if (current is! ChefProfileLoaded) return;

    final original = current.profile;
    // Optimistic update — reverted below if the call fails.
    emit(current.copyWith(
        profile: original.copyWith(isFollowing: !original.isFollowing)));

    final result = await _toggleFollowChef(original.id,
        wasFollowing: original.isFollowing);
    if (isClosed) return;
    result.fold(
      (_) {},
      (exception) {
        final stillLoaded = state;
        if (stillLoaded is ChefProfileLoaded) {
          emit(stillLoaded.copyWith(profile: original));
        }
      },
    );
  }
}
