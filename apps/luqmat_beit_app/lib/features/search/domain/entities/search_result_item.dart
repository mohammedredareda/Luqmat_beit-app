import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_item.freezed.dart';

/// One row in the Search results list — the backend can return a mix of
/// result kinds in a single page (`types=meals,offers,cooks,returned_meals`),
/// so the paginated list is a flat, ordered list of this union rather than
/// four separate lists, letting it reuse `PaginatedResult`/
/// `PaginationStateMixin`/`PaginatedListView` unchanged.
@freezed
sealed class SearchResultItem with _$SearchResultItem {
  const factory SearchResultItem.meal(MealEntity meal) = SearchResultMeal;
  const factory SearchResultItem.offer(OfferBundleEntity offer) =
      SearchResultOffer;
  const factory SearchResultItem.cook(ChefSummaryEntity cook) =
      SearchResultCook;
  const factory SearchResultItem.returnedMeal(ReturnedMealEntity returnedMeal) =
      SearchResultReturnedMeal;
}
