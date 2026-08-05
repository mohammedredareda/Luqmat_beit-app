import 'package:equatable/equatable.dart';

/// One meal included in an [OfferEntity] bundle, along with the quantity
/// and (if the meal has variations) which selling option was chosen.
class OfferMealEntity extends Equatable {
  const OfferMealEntity({
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.unitPrice,
    required this.quantity,
    this.sellingOptionId,
    this.sellingOptionLabel,
  });

  final String mealId;
  final String mealName;
  final String mealImageUrl;

  /// Both null when the meal sells at a single flat price.
  final String? sellingOptionId;
  final String? sellingOptionLabel;

  final double unitPrice;
  final int quantity;

  @override
  List<Object?> get props =>
      [mealId, mealName, mealImageUrl, sellingOptionId, sellingOptionLabel, unitPrice, quantity];
}
