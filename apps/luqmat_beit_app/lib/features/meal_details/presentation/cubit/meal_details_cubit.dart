import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_meal_to_cart.dart';
import '../../domain/usecases/get_meal_details.dart';
import '../../domain/usecases/toggle_meal_favorite.dart';
import 'meal_details_state.dart';

class MealDetailsCubit extends Cubit<MealDetailsState> {
  MealDetailsCubit(this._getMealDetails, this._addMealToCart, this._toggleMealFavorite)
      : super(const MealDetailsState.initial());

  final GetMealDetails _getMealDetails;
  final AddMealToCart _addMealToCart;
  final ToggleMealFavorite _toggleMealFavorite;

  String? _mealId;

  Future<void> loadMeal(String mealId) async {
    _mealId = mealId;
    emit(const MealDetailsState.loading());
    final result = await _getMealDetails(mealId);
    result.fold(
      (meal) => emit(MealDetailsState.loaded(
        meal: meal,
        selectedSellingOptionId: meal.sellingOptions.isNotEmpty
            ? meal.sellingOptions.first.id
            : '',
      )),
      (exception) => emit(MealDetailsState.failure(exception)),
    );
  }

  void selectSellingOption(String sellingOptionId) {
    final current = state;
    if (current is MealDetailsLoaded) {
      emit(current.copyWith(selectedSellingOptionId: sellingOptionId));
    }
  }

  void incrementQuantity() {
    final current = state;
    if (current is MealDetailsLoaded) {
      emit(current.copyWith(quantity: current.quantity + 1));
    }
  }

  void decrementQuantity() {
    final current = state;
    if (current is MealDetailsLoaded && current.quantity > 1) {
      emit(current.copyWith(quantity: current.quantity - 1));
    }
  }

  void updateNote(String note) {
    final current = state;
    if (current is MealDetailsLoaded) {
      emit(current.copyWith(note: note));
    }
  }

  Future<void> retry() async {
    final mealId = _mealId;
    if (mealId != null) await loadMeal(mealId);
  }

  void toggleFavorite() {
    final current = state;
    if (current is MealDetailsLoaded) {
      final newValue = !current.isFavorite;
      emit(current.copyWith(isFavorite: newValue));
      // Fire-and-forget: the heart icon already reflects the optimistic
      // local state above; a failure here isn't worth blocking or
      // reverting the UI over.
      _toggleMealFavorite(current.meal.id, newValue);
    }
  }

  /// Called by the page after it has shown the "added to cart"
  /// confirmation, so a second tap on the button doesn't re-trigger the
  /// listener for a state it already handled.
  void acknowledgeAddedToCart() {
    final current = state;
    if (current is MealDetailsAddedToCart) {
      emit(MealDetailsState.loaded(
        meal: current.meal,
        selectedSellingOptionId: current.selectedSellingOptionId,
        quantity: current.quantity,
        note: current.note,
        isFavorite: current.isFavorite,
      ));
    }
  }

  Future<void> addToCart() async {
    final current = state;
    if (current is! MealDetailsLoaded) return;

    final result = await _addMealToCart(
      mealId: current.meal.id,
      sellingOptionId: current.selectedSellingOptionId,
      quantity: current.quantity,
      note: current.note.isEmpty ? null : current.note,
    );
    result.fold(
      (_) => emit(MealDetailsState.addedToCart(
        meal: current.meal,
        selectedSellingOptionId: current.selectedSellingOptionId,
        quantity: current.quantity,
        note: current.note,
        isFavorite: current.isFavorite,
      )),
      (exception) => emit(MealDetailsState.failure(exception)),
    );
  }
}
