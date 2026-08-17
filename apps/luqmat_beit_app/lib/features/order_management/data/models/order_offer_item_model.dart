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

  /// TODO(backend): the live docs' order-detail example always shows an
  /// empty `offerItems` array — this shape is a best-effort guess mirroring
  /// `mealItems`, unconfirmed against a real non-empty response.
  factory OrderOfferItemModel.fromApiJson(Map<String, dynamic> json) {
    final offer = json['offer'] as Map?;
    return OrderOfferItemModel(
      id: json['id']?.toString() ?? '',
      offerId: json['offerId']?.toString() ?? '',
      offerName: json['offerName'] as String? ?? offer?['name'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 1,
      priceAtPurchase: double.tryParse(json['priceAtPurchase']?.toString() ?? '') ?? 0,
    );
  }

  OrderOfferItemEntity toEntity() => OrderOfferItemEntity(
        id: id,
        offerId: offerId,
        offerName: offerName,
        quantity: quantity,
        priceAtPurchase: priceAtPurchase,
        mealNames: mealNames,
      );
}
