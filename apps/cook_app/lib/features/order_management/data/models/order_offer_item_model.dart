import 'package:core/core.dart';

class OrderOfferItemModel {
  const OrderOfferItemModel({
    required this.offerId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.priceAtPurchase,
    this.note,
  });

  final String offerId;
  final String name;
  final String imageUrl;
  final int quantity;
  final double priceAtPurchase;
  final String? note;

  factory OrderOfferItemModel.fromJson(Map<String, dynamic> json) => OrderOfferItemModel(
        offerId: json['offerId'] as String,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
        quantity: json['quantity'] as int,
        priceAtPurchase: (json['priceAtPurchase'] as num).toDouble(),
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'offerId': offerId,
        'name': name,
        'imageUrl': imageUrl,
        'quantity': quantity,
        'priceAtPurchase': priceAtPurchase,
        'note': note,
      };

  OrderOfferItemEntity toEntity() => OrderOfferItemEntity(
        offerId: offerId,
        name: name,
        imageUrl: imageUrl,
        quantity: quantity,
        priceAtPurchase: priceAtPurchase,
        note: note,
      );
}
