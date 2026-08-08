import 'package:equatable/equatable.dart';

enum ReturnedMealStatus { available, claimed, returnedToCook, destroyed, expired }

/// A meal returned/salvaged by a cook (powers CU-06 — discounted "من
/// نصيبك" listings near their expiry window). `originalItemId` links back
/// to the `ORDER_MEAL_ITEM` it originated from.
class ReturnedMealEntity extends Equatable {
  final String id;
  final String originalItemId;
  final String mealId;
  final String mealName;
  final String imageUrl;
  final double originalPrice;
  final double salvagePrice;
  final DateTime expiryTime;
  final int quantity;
  final String? sellingOptionId;
  final ReturnedMealStatus status;

  const ReturnedMealEntity({
    required this.id,
    required this.originalItemId,
    required this.mealId,
    required this.mealName,
    required this.imageUrl,
    required this.originalPrice,
    required this.salvagePrice,
    required this.expiryTime,
    required this.quantity,
    this.sellingOptionId,
    this.status = ReturnedMealStatus.available,
  });

  bool get isExpired => DateTime.now().isAfter(expiryTime);

  @override
  List<Object?> get props => [
        id,
        originalItemId,
        mealId,
        mealName,
        imageUrl,
        originalPrice,
        salvagePrice,
        expiryTime,
        quantity,
        sellingOptionId,
        status,
      ];
}
