import 'package:core/core.dart';

class OrderReturnedMealItemModel {
  const OrderReturnedMealItemModel({
    required this.id,
    required this.returnedMealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.quantity,
    required this.priceAtPurchase,
  });

  final String id;
  final String returnedMealId;
  final String mealName;
  final String mealImageUrl;
  final int quantity;
  final double priceAtPurchase;

  factory OrderReturnedMealItemModel.fromJson(Map<String, dynamic> json) =>
      OrderReturnedMealItemModel(
        id: json['id'] as String,
        returnedMealId: json['returnedMealId'] as String,
        mealName: json['mealName'] as String,
        mealImageUrl: json['mealImageUrl'] as String,
        quantity: json['quantity'] as int,
        priceAtPurchase: (json['priceAtPurchase'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'returnedMealId': returnedMealId,
        'mealName': mealName,
        'mealImageUrl': mealImageUrl,
        'quantity': quantity,
        'priceAtPurchase': priceAtPurchase,
      };

  OrderReturnedMealItemEntity toEntity() => OrderReturnedMealItemEntity(
        id: id,
        returnedMealId: returnedMealId,
        mealName: mealName,
        mealImageUrl: mealImageUrl,
        quantity: quantity,
        priceAtPurchase: priceAtPurchase,
      );
}
