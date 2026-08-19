import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_details_state.freezed.dart';

/// CU-09/CU-10 is a single fetch-and-display flow plus one follow-up
/// "add to cart" action — not multiple UI-distinct exception flows — hence
/// a Cubit with a plain state union, not a Bloc with explicit events.
@freezed
sealed class MealDetailsState with _$MealDetailsState {
  const factory MealDetailsState.initial() = MealDetailsInitial;

  const factory MealDetailsState.loading() = MealDetailsLoading;

  const factory MealDetailsState.loaded({
    required MealEntity meal,
    required String selectedSellingOptionId,
    @Default(1) int quantity,
    @Default('') String note,
    @Default(false) bool isFavorite,
    /// Set when this screen was reached from a "Your Own" (returned/salvage
    /// meal) card — swaps the price/CTA to the salvage flow instead of the
    /// normal selling-option one.
    ReturnedMealEntity? returnedMeal,
  }) = MealDetailsLoaded;

  /// Emitted once, right after a successful `addToCart` call, so the page
  /// can show a confirmation without losing the current selection —
  /// carries the same fields as [MealDetailsLoaded].
  const factory MealDetailsState.addedToCart({
    required MealEntity meal,
    required String selectedSellingOptionId,
    @Default(1) int quantity,
    @Default('') String note,
    @Default(false) bool isFavorite,
    ReturnedMealEntity? returnedMeal,
  }) = MealDetailsAddedToCart;

  const factory MealDetailsState.failure(AppException exception) =
      MealDetailsFailure;
}
