import 'package:core/core.dart';

class OrderReturnedMealItemModel {
  const OrderReturnedMealItemModel({
    required this.mealId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.priceAtPurchase,
    required this.returnedReason,
    this.note,
  });

  final String mealId;
  final String name;
  final String imageUrl;
  final int quantity;
  final double priceAtPurchase;
  final String returnedReason;
  final String? note;

  factory OrderReturnedMealItemModel.fromJson(Map<String, dynamic> json) =>
      OrderReturnedMealItemModel(
        mealId: json['mealId'] as String,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
        quantity: json['quantity'] as int,
        priceAtPurchase: (json['priceAtPurchase'] as num).toDouble(),
        returnedReason: json['returnedReason'] as String,
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'mealId': mealId,
        'name': name,
        'imageUrl': imageUrl,
        'quantity': quantity,
        'priceAtPurchase': priceAtPurchase,
        'returnedReason': returnedReason,
        'note': note,
      };

  OrderReturnedMealItemEntity toEntity() => OrderReturnedMealItemEntity(
        mealId: mealId,
        name: name,
        imageUrl: imageUrl,
        quantity: quantity,
        priceAtPurchase: priceAtPurchase,
        returnedReason: returnedReason,
        note: note,
      );
}
