import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/home_feed_entity.dart';

part 'home_state.freezed.dart';

/// Single fetch-and-display flow (CU-05/06/07), no branching outcomes —
/// hence a Cubit with a plain loading/loaded/error state, not a Bloc.
@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitial;
  const factory HomeState.loading() = HomeLoading;
  const factory HomeState.loaded(HomeFeedEntity feed) = HomeLoaded;
  const factory HomeState.failure(AppException exception) = HomeFailure;
}
