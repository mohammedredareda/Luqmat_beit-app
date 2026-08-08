import 'package:equatable/equatable.dart';

/// One `offer_meal` junction row — `variationQuantity` is how many units of
/// this meal are included in the bundle.
class OfferMealEntity extends Equatable {
  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final int variationQuantity;

  const OfferMealEntity({
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.variationQuantity,
  });

  @override
  List<Object?> get props =>
      [mealId, mealName, mealImageUrl, variationQuantity];
}
