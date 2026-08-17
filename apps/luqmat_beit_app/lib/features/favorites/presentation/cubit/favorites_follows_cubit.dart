import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_favorite_meals.dart';
import '../../domain/usecases/get_followed_chefs.dart';
import '../../domain/usecases/unfavorite_meal.dart';
import '../../domain/usecases/unfollow_chef.dart';
import 'favorites_follows_state.dart';

class FavoritesFollowsCubit extends Cubit<FavoritesFollowsState> {
  FavoritesFollowsCubit(
    this._getFavoriteMeals,
    this._getFollowedChefs,
    this._unfavoriteMeal,
    this._unfollowChef,
  ) : super(const FavoritesFollowsState.initial());

  final GetFavoriteMeals _getFavoriteMeals;
  final GetFollowedChefs _getFollowedChefs;
  final UnfavoriteMeal _unfavoriteMeal;
  final UnfollowChef _unfollowChef;

  Future<void> load() async {
    emit(const FavoritesFollowsState.loading());

    final mealsResult = await _getFavoriteMeals();
    final chefsResult = await _getFollowedChefs();
    if (isClosed) return;

    mealsResult.fold(
      (meals) => chefsResult.fold(
        (chefs) => emit(FavoritesFollowsState.loaded(meals, chefs, FavoritesTab.meals)),
        (exception) => emit(FavoritesFollowsState.failure(exception)),
      ),
      (exception) => emit(FavoritesFollowsState.failure(exception)),
    );
  }

  void selectTab(FavoritesTab tab) {
    final current = state;
    if (current is FavoritesFollowsLoaded) {
      emit(FavoritesFollowsState.loaded(current.meals, current.chefs, tab));
    }
  }

  Future<void> unfavoriteMeal(String mealId) async {
    final current = state;
    if (current is! FavoritesFollowsLoaded) return;

    final result = await _unfavoriteMeal(mealId);
    if (isClosed) return;
    result.fold(
      (_) => emit(
        FavoritesFollowsState.loaded(
          current.meals.where((meal) => meal.id != mealId).toList(),
          current.chefs,
          current.activeTab,
        ),
      ),
      (exception) => emit(FavoritesFollowsState.failure(exception)),
    );
  }

  Future<void> unfollowChef(String chefId) async {
    final current = state;
    if (current is! FavoritesFollowsLoaded) return;

    final result = await _unfollowChef(chefId);
    if (isClosed) return;
    result.fold(
      (_) => emit(
        FavoritesFollowsState.loaded(
          current.meals,
          current.chefs.where((chef) => chef.id != chefId).toList(),
          current.activeTab,
        ),
      ),
      (exception) => emit(FavoritesFollowsState.failure(exception)),
    );
  }
}
