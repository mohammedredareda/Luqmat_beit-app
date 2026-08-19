import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

// `ChefSummaryEntity`/`OfferBundleEntity`/`OfferBundleMealEntity` moved to
// `packages/core` once the Search feature needed the same shapes for its
// `cooks`/`offers` results — re-exported here so every existing import of
// this file (`category_chip.dart`, `chef_list_tile.dart`, `home_page.dart`)
// keeps working unchanged.
export 'package:core/core.dart'
    show ChefSummaryEntity, OfferBundleEntity, OfferBundleMealEntity;

class CategoryEntity extends Equatable {
  final String id;
  final String label;
  final String iconName;

  const CategoryEntity(
      {required this.id, required this.label, required this.iconName});

  @override
  List<Object?> get props => [id, label, iconName];
}

/// Aggregates everything the Home screen renders (CU-05/06/07) — one fetch,
/// one render, hence a Cubit rather than a Bloc.
class HomeFeedEntity extends Equatable {
  final List<CategoryEntity> categories;
  final List<MealEntity> bestSellers;
  final List<ChefSummaryEntity> chefs;
  final List<OfferBundleEntity> offerBundles;
  final List<MealEntity> discountedMeals;
  final Map<String, DiscountEntity> discountsByMealId;
  final List<ReturnedMealEntity> returnedMeals;

  const HomeFeedEntity({
    required this.categories,
    required this.bestSellers,
    required this.chefs,
    required this.offerBundles,
    required this.discountedMeals,
    required this.discountsByMealId,
    required this.returnedMeals,
  });

  @override
  List<Object?> get props => [
        categories,
        bestSellers,
        chefs,
        offerBundles,
        discountedMeals,
        discountsByMealId,
        returnedMeals,
      ];
}
