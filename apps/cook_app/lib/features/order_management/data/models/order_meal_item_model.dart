import 'package:core/core.dart';

class OrderMealItemModel {
  const OrderMealItemModel({
    required this.mealId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.priceAtPurchase,
    this.note,
    this.selectedOptionLabel,
  });

  final String mealId;
  final String name;
  final String imageUrl;
  final int quantity;
  final double priceAtPurchase;
  final String? note;
  final String? selectedOptionLabel;

  factory OrderMealItemModel.fromJson(Map<String, dynamic> json) => OrderMealItemModel(
        mealId: json['mealId'] as String,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
        quantity: json['quantity'] as int,
        priceAtPurchase: (json['priceAtPurchase'] as num).toDouble(),
        note: json['note'] as String?,
        selectedOptionLabel: json['selectedOptionLabel'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'mealId': mealId,
        'name': name,
        'imageUrl': imageUrl,
        'quantity': quantity,
        'priceAtPurchase': priceAtPurchase,
        'note': note,
        'selectedOptionLabel': selectedOptionLabel,
      };

  OrderMealItemEntity toEntity() => OrderMealItemEntity(
        mealId: mealId,
        name: name,
        imageUrl: imageUrl,
        quantity: quantity,
        priceAtPurchase: priceAtPurchase,
        note: note,
        selectedOptionLabel: selectedOptionLabel,
      );
}
