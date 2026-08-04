import 'package:core/core.dart';

class OfferMealModel {
  const OfferMealModel({
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
  final String? sellingOptionId;
  final String? sellingOptionLabel;
  final double unitPrice;
  final int quantity;

  factory OfferMealModel.fromJson(Map<String, dynamic> json) => OfferMealModel(
        mealId: json['mealId'] as String,
        mealName: json['mealName'] as String,
        mealImageUrl: json['mealImageUrl'] as String,
        sellingOptionId: json['sellingOptionId'] as String?,
        sellingOptionLabel: json['sellingOptionLabel'] as String?,
        unitPrice: (json['unitPrice'] as num).toDouble(),
        quantity: json['quantity'] as int,
      );

  Map<String, dynamic> toJson() => {
        'mealId': mealId,
        'mealName': mealName,
        'mealImageUrl': mealImageUrl,
        'sellingOptionId': sellingOptionId,
        'sellingOptionLabel': sellingOptionLabel,
        'unitPrice': unitPrice,
        'quantity': quantity,
      };

  OfferMealEntity toEntity() => OfferMealEntity(
        mealId: mealId,
        mealName: mealName,
        mealImageUrl: mealImageUrl,
        sellingOptionId: sellingOptionId,
        sellingOptionLabel: sellingOptionLabel,
        unitPrice: unitPrice,
        quantity: quantity,
      );
}
