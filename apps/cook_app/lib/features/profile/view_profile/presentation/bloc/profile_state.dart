import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/cook_profile_details.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.loaded(CookProfileDetails profile) = ProfileLoaded;
  const factory ProfileState.error(AppException exception) = ProfileError;
}
