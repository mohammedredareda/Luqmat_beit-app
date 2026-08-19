import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/chef_profile_entity.dart';

part 'chef_profile_state.freezed.dart';

/// Single fetch-and-display flow (CU-11) — chef info, follow toggle, and
/// this chef's meal list all come from one `getChefProfile` call, no
/// UI-distinct alternative flows — hence a Cubit, not a Bloc.
@freezed
sealed class ChefProfileState with _$ChefProfileState {
  const factory ChefProfileState.initial() = ChefProfileInitial;
  const factory ChefProfileState.loading() = ChefProfileLoading;
  const factory ChefProfileState.loaded(
    ChefProfileEntity profile, {
    @Default('') String searchQuery,
    String? selectedTag,
  }) = ChefProfileLoaded;
  const factory ChefProfileState.failure(AppException exception) =
      ChefProfileFailure;
}
