import 'package:equatable/equatable.dart';

/// One meal row inside a bundle [OfferBundleEntity] — carries its own
/// price/discount since a bundle's per-meal pricing can differ from that
/// meal's normal catalog price.
class OfferBundleMealEntity extends Equatable {
  final String mealId;
  final String name;
  final String imageUrl;
  final String variationLabel;
  final double price;
  final double finalPrice;

  const OfferBundleMealEntity({
    required this.mealId,
    required this.name,
    required this.imageUrl,
    required this.variationLabel,
    required this.price,
    required this.finalPrice,
  });

  @override
  List<Object?> get props =>
      [mealId, name, imageUrl, variationLabel, price, finalPrice];
}

/// A multi-meal promotional bundle — from Home's `GET /user/customer/offers`
/// (`offers[]`) and Search's `offers` results (`GET /user/customer/search`,
/// `types` including `offers`). Distinct from [DiscountEntity], which
/// discounts a single meal.
class OfferBundleEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double totalPrice;
  final DateTime expireTime;
  final List<OfferBundleMealEntity> meals;

  const OfferBundleEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.totalPrice,
    required this.expireTime,
    required this.meals,
  });

  @override
  List<Object?> get props =>
      [id, name, description, totalPrice, expireTime, meals];
}
