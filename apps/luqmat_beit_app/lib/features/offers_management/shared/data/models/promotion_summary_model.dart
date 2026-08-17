enum PromotionItemType { offer, discount }

/// One row of `GET /user/cook/menu/promotions/my-promotions` — see
/// `OfferFeedItemEntity`'s doc comment for the shape this mirrors. Still a
/// pre-rendered title/description (no separate meal/price fields), but each
/// row does carry an [image] URL now. A discount is limited either by time
/// ([expiryTime]) or by a usage count ([usageRemaining]), never necessarily
/// both — confirmed live, a usage-limited discount has `expireTime: null`.
class PromotionSummaryModel {
  const PromotionSummaryModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.expiryTime,
    required this.isActive,
    this.image,
    this.usageRemaining,
  });

  final String id;
  final PromotionItemType type;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? expiryTime;
  final bool isActive;
  final String? image;
  final int? usageRemaining;

  factory PromotionSummaryModel.fromJson(Map<String, dynamic> json) => PromotionSummaryModel(
        id: json['id'].toString(),
        type: (json['itemType'] as String?) == 'DISCOUNT'
            ? PromotionItemType.discount
            : PromotionItemType.offer,
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
        expiryTime: json['expireTime'] == null
            ? null
            : DateTime.tryParse(json['expireTime'].toString()),
        isActive: json['isActive'] as bool? ?? true,
        image: json['image'] as String?,
        usageRemaining: json['usageRemaining'] as int?,
      );
}
