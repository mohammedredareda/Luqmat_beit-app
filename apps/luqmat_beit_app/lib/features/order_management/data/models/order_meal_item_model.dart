import 'package:core/core.dart';

class OrderMealItemModel {
  const OrderMealItemModel({
    required this.id,
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.quantity,
    required this.priceAtPurchase,
    this.note,
    this.sellingOptionLabel,
  });

  final String id;
  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final int quantity;
  final double priceAtPurchase;
  final String? note;
  final String? sellingOptionLabel;

  factory OrderMealItemModel.fromJson(Map<String, dynamic> json) => OrderMealItemModel(
        id: json['id'] as String,
        mealId: json['mealId'] as String,
        mealName: json['mealName'] as String,
        mealImageUrl: json['mealImageUrl'] as String,
        quantity: json['quantity'] as int,
        priceAtPurchase: (json['priceAtPurchase'] as num).toDouble(),
        note: json['note'] as String?,
        sellingOptionLabel: json['sellingOptionLabel'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'mealId': mealId,
        'mealName': mealName,
        'mealImageUrl': mealImageUrl,
        'quantity': quantity,
        'priceAtPurchase': priceAtPurchase,
        'note': note,
        'sellingOptionLabel': sellingOptionLabel,
      };

  /// Real-shape response parsing from `GET /user/cook/orders/{id}`'s
  /// `mealItems[]` — nested `meal:{name,image}` and
  /// `sellingOption:{variation}`, `notes` (not `note`).
  factory OrderMealItemModel.fromApiJson(Map<String, dynamic> json) {
    final meal = json['meal'] as Map?;
    final sellingOption = json['sellingOption'] as Map?;
    return OrderMealItemModel(
      id: json['id'].toString(),
      mealId: json['mealId']?.toString() ?? '',
      mealName: meal?['name'] as String? ?? '',
      mealImageUrl: meal?['image'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 1,
      priceAtPurchase: double.tryParse(json['priceAtPurchase']?.toString() ?? '') ?? 0,
      note: json['notes'] as String?,
      sellingOptionLabel: sellingOption?['variation'] as String?,
    );
  }

  OrderMealItemEntity toEntity() => OrderMealItemEntity(
        id: id,
        mealId: mealId,
        mealName: mealName,
        mealImageUrl: mealImageUrl,
        quantity: quantity,
        priceAtPurchase: priceAtPurchase,
        note: note,
        sellingOptionLabel: sellingOptionLabel,
      );
}
