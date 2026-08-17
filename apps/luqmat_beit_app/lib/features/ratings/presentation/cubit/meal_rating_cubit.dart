import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_order_to_rate.dart';
import '../../domain/usecases/submit_meal_rating.dart';
import 'meal_rating_state.dart';

class MealRatingCubit extends Cubit<MealRatingState> {
  MealRatingCubit(this._getOrderToRate, this._submitMealRating)
      : super(const MealRatingState.initial());

  final GetOrderToRate _getOrderToRate;
  final SubmitMealRating _submitMealRating;

  Future<void> loadOrder(String orderId) async {
    emit(const MealRatingState.loading());
    final result = await _getOrderToRate(orderId);
    if (isClosed) return;
    result.fold(
      (order) => emit(MealRatingState.loaded(order: order)),
      (exception) => emit(MealRatingState.failure(exception)),
    );
  }

  void selectStars(int stars) {
    final current = state;
    if (current is MealRatingLoaded) {
      emit(current.copyWith(stars: stars, submitError: null));
    }
  }

  void updateReview(String review) {
    final current = state;
    if (current is MealRatingLoaded) {
      emit(current.copyWith(review: review));
    }
  }

  Future<void> submit() async {
    final current = state;
    if (current is! MealRatingLoaded || current.stars < 1) return;

    emit(current.copyWith(isSubmitting: true, submitError: null));
    final mealItems = current.order.mealItems;
    final mealId = mealItems.isNotEmpty ? mealItems.first.mealId : null;
    final result = await _submitMealRating(
      orderId: current.order.id,
      stars: current.stars,
      review: current.review.trim().isEmpty ? null : current.review.trim(),
      mealId: mealId,
    );
    if (isClosed) return;
    result.fold(
      (_) => emit(const MealRatingState.submitted()),
      (exception) =>
          emit(current.copyWith(isSubmitting: false, submitError: exception)),
    );
  }
}
