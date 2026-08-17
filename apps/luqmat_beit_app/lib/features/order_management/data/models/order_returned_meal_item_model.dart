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

  /// TODO(backend): the live docs' order-detail example always shows an
  /// empty `returnedMealItems` array — this shape is a best-effort guess
  /// mirroring `mealItems`, unconfirmed against a real non-empty response.
  factory OrderReturnedMealItemModel.fromApiJson(Map<String, dynamic> json) {
    final meal = json['meal'] as Map?;
    return OrderReturnedMealItemModel(
      id: json['id']?.toString() ?? '',
      returnedMealId: json['returnedMealId']?.toString() ?? '',
      mealName: json['mealName'] as String? ?? meal?['name'] as String? ?? '',
      mealImageUrl: json['mealImageUrl'] as String? ?? meal?['image'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 1,
      priceAtPurchase: double.tryParse(json['priceAtPurchase']?.toString() ?? '') ?? 0,
    );
  }

  OrderReturnedMealItemEntity toEntity() => OrderReturnedMealItemEntity(
        id: id,
        returnedMealId: returnedMealId,
        mealName: mealName,
        mealImageUrl: mealImageUrl,
        quantity: quantity,
        priceAtPurchase: priceAtPurchase,
      );
}
