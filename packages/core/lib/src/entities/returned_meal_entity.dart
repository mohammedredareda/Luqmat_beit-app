import 'package:equatable/equatable.dart';

/// A meal returned/salvaged by a cook (powers CU-06 — discounted "rescue"
/// listings near their expiry window).
class ReturnedMealEntity extends Equatable {
  final String id;
  final String mealId;
  final String mealName;
  final String imageUrl;
  final double originalPrice;
  final double salvagePrice;
  final DateTime expiryTime;

  const ReturnedMealEntity({
    required this.id,
    required this.mealId,
    required this.mealName,
    required this.imageUrl,
    required this.originalPrice,
    required this.salvagePrice,
    required this.expiryTime,
  });

  bool get isExpired => DateTime.now().isAfter(expiryTime);

  @override
  List<Object?> get props => [
        id,
        mealId,
        mealName,
        imageUrl,
        originalPrice,
        salvagePrice,
        expiryTime,
      ];
}
