import 'package:core/core.dart';

class OrderOfferItemModel {
  const OrderOfferItemModel({
    required this.id,
    required this.offerId,
    required this.offerName,
    required this.quantity,
    required this.priceAtPurchase,
    this.mealNames = const [],
  });

  final String id;
  final String offerId;
  final String offerName;
  final int quantity;
  final double priceAtPurchase;
  final List<String> mealNames;

  factory OrderOfferItemModel.fromJson(Map<String, dynamic> json) => OrderOfferItemModel(
        id: json['id'] as String,
        offerId: json['offerId'] as String,
        offerName: json['offerName'] as String,
        quantity: json['quantity'] as int,
        priceAtPurchase: (json['priceAtPurchase'] as num).toDouble(),
        mealNames: (json['mealNames'] as List<dynamic>? ?? []).cast<String>(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'offerId': offerId,
        'offerName': offerName,
        'quantity': quantity,
        'priceAtPurchase': priceAtPurchase,
        'mealNames': mealNames,
      };

  OrderOfferItemEntity toEntity() => OrderOfferItemEntity(
        id: id,
        offerId: offerId,
        offerName: offerName,
        quantity: quantity,
        priceAtPurchase: priceAtPurchase,
        mealNames: mealNames,
      );
}
