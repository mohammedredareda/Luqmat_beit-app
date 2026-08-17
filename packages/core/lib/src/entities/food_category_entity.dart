import 'package:equatable/equatable.dart';

/// A meal category from `GET /user/customer/categories` — shared by both
/// customer browsing and cook meal-creation despite the URL's `customer`
/// segment (same catalog serves both roles, it's just where the endpoint
/// happens to live). Two levels deep: top-level categories optionally carry
/// [subcategories], which never nest further per the live API shape.
///
/// Named `FoodCategoryEntity` rather than `CategoryEntity` to avoid
/// colliding with the customer Home feature's pre-existing, unrelated
/// `CategoryEntity` (a flat id/label/iconName shape used only for chip
/// rendering on the Home screen) — that local type is intentionally left
/// alone rather than merged into this one.
class FoodCategoryEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final List<FoodCategoryEntity> subcategories;

  const FoodCategoryEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.subcategories = const [],
  });

  @override
  List<Object?> get props => [id, name, imageUrl, subcategories];
}
