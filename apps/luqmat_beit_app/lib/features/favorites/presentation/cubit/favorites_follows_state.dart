import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'favorites_follows_state.freezed.dart';

/// Which of the two tabs (CU-12 favorited meals / CU-13 followed chefs) is
/// currently shown.
enum FavoritesTab { meals, chefs }

/// Single fetch-and-display flow (CU-12/13) with an unfavorite/unfollow
/// toggle action (CU-14) — no UI-distinct alternative flows, hence a Cubit
/// per the architecture doc's §6 decision rule.
@freezed
sealed class FavoritesFollowsState with _$FavoritesFollowsState {
  const factory FavoritesFollowsState.initial() = FavoritesFollowsInitial;
  const factory FavoritesFollowsState.loading() = FavoritesFollowsLoading;
  const factory FavoritesFollowsState.loaded(
    List<MealEntity> meals,
    List<ChefSummaryEntity> chefs,
    FavoritesTab activeTab,
  ) = FavoritesFollowsLoaded;
  const factory FavoritesFollowsState.failure(AppException exception) =
      FavoritesFollowsFailure;
}
