import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../meal_details/domain/usecases/report_meal.dart';
import '../../domain/usecases/get_order_to_rate.dart';
import '../../domain/usecases/submit_meal_rating.dart';
import 'meal_rating_state.dart';

class MealRatingCubit extends Cubit<MealRatingState> {
  MealRatingCubit(this._getOrderToRate, this._submitMealRating, this._reportMeal)
      : super(const MealRatingState.initial());

  final GetOrderToRate _getOrderToRate;
  final SubmitMealRating _submitMealRating;
  final ReportMeal _reportMeal;

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

  /// Backs the "إبلاغ" escape hatch on this same screen — same backend
  /// endpoint/DTO as the meal-details report action ([ReportMeal]), since a
  /// meal reached via a rating screen is always from a delivered order,
  /// which is the one precondition that endpoint enforces.
  Future<Result<void>> reportIssue(String message) {
    final current = state;
    if (current is! MealRatingLoaded) {
      return Future.value(
        const Result.failure(UnknownException('لا يوجد طلب محمّل.')),
      );
    }
    final mealItems = current.order.mealItems;
    final mealId = mealItems.isNotEmpty ? mealItems.first.mealId : null;
    if (mealId == null) {
      return Future.value(
        const Result.failure(UnknownException('تعذر تحديد الوجبة المطلوب الإبلاغ عنها.')),
      );
    }
    return _reportMeal(mealId, message);
  }
}
