enum PromotionItemType { offer, discount }

/// One row of `GET /user/cook/menu/offers/my-promotions` — see
/// `OfferFeedItemEntity`'s doc comment for why this is thin (no meal/image/
/// price detail, just a pre-rendered title/description).
class PromotionSummaryModel {
  const PromotionSummaryModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.expiryTime,
    required this.isActive,
  });

  final String id;
  final PromotionItemType type;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime expiryTime;
  final bool isActive;

  factory PromotionSummaryModel.fromJson(Map<String, dynamic> json) => PromotionSummaryModel(
        id: json['id'].toString(),
        type: (json['itemType'] as String?) == 'DISCOUNT'
            ? PromotionItemType.discount
            : PromotionItemType.offer,
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
        expiryTime: DateTime.tryParse(json['expireTime']?.toString() ?? '') ?? DateTime.now(),
        isActive: json['isActive'] as bool? ?? true,
      );
}
