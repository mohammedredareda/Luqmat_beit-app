import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String label;
  final String iconName;

  const CategoryEntity({required this.id, required this.label, required this.iconName});

  @override
  List<Object?> get props => [id, label, iconName];
}

class ChefSummaryEntity extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final double rating;
  final int ratingCount;
  final double distanceKm;

  const ChefSummaryEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.ratingCount,
    required this.distanceKm,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl, rating, ratingCount, distanceKm];
}

/// Aggregates everything the Home screen renders (CU-05/06/07) — one fetch,
/// one render, hence a Cubit rather than a Bloc.
class HomeFeedEntity extends Equatable {
  final List<CategoryEntity> categories;
  final List<MealEntity> bestSellers;
  final List<ChefSummaryEntity> chefs;
  final List<MealEntity> offers;
  final List<MealEntity> bigDiscounts;
  final Map<String, DiscountEntity> discountsByMealId;

  const HomeFeedEntity({
    required this.categories,
    required this.bestSellers,
    required this.chefs,
    required this.offers,
    required this.bigDiscounts,
    required this.discountsByMealId,
  });

  @override
  List<Object?> get props =>
      [categories, bestSellers, chefs, offers, bigDiscounts, discountsByMealId];
}
