import 'package:core/core.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';

/// [deletedAt] is data-layer-only (CK-15 soft delete), mirroring
/// `OfferModel`/`MealModel`'s convention. `mealName`/`mealImageUrl`/
/// `mealBasePrice` are denormalized display fields — not part of the
/// shared [DiscountEntity], which only carries `mealId`.
class DiscountModel {
  const DiscountModel({
    required this.id,
    required this.cookId,
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.mealBasePrice,
    required this.discountPercentage,
    required this.discountDurationDays,
    required this.createdAt,
    required this.expiryTime,
    this.usageNumberLimit,
    this.usageCount = 0,
    this.status = DiscountStatus.active,
    this.deletedAt,
  });

  final String id;
  final String cookId;
  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final double mealBasePrice;
  final double discountPercentage;
  final int discountDurationDays;
  final int? usageNumberLimit;
  final int usageCount;
  final DateTime createdAt;
  final DateTime expiryTime;
  final DiscountStatus status;
  final DateTime? deletedAt;

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        id: json['id'] as String,
        cookId: json['cookId'] as String,
        mealId: json['mealId'] as String,
        mealName: json['mealName'] as String,
        mealImageUrl: json['mealImageUrl'] as String,
        mealBasePrice: (json['mealBasePrice'] as num).toDouble(),
        discountPercentage: (json['discountPercentage'] as num).toDouble(),
        discountDurationDays: json['discountDurationDays'] as int,
        usageNumberLimit: json['usageNumberLimit'] as int?,
        usageCount: json['usageCount'] as int? ?? 0,
        createdAt: DateTime.parse(json['createdAt'] as String),
        expiryTime: DateTime.parse(json['expiryTime'] as String),
        status: DiscountStatus.values.byName(json['status'] as String),
        deletedAt:
            json['deletedAt'] == null ? null : DateTime.parse(json['deletedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cookId': cookId,
        'mealId': mealId,
        'mealName': mealName,
        'mealImageUrl': mealImageUrl,
        'mealBasePrice': mealBasePrice,
        'discountPercentage': discountPercentage,
        'discountDurationDays': discountDurationDays,
        'usageNumberLimit': usageNumberLimit,
        'usageCount': usageCount,
        'createdAt': createdAt.toIso8601String(),
        'expiryTime': expiryTime.toIso8601String(),
        'status': status.name,
        'deletedAt': deletedAt?.toIso8601String(),
      };

  /// Real-shape response parsing from `GET /user/cook/menu/discounts/{id}`
  /// — `discountDuration`/`usageLimit` (not `discountDurationDays`/
  /// `usageNumberLimit`), `discountPercentage` as a numeric string,
  /// `status` as a bool, meal display info nested under `meal`. No
  /// `cookId` in the response — [DiscountEntity] doesn't carry one either,
  /// so the placeholder here is never actually read. No meal price/selling
  /// options either — [mealBasePrice] defaults to 0 (see
  /// `EditDiscountRepositoryImpl`, which surfaces this as an unavailable
  /// "current price" preview rather than a fabricated number).
  factory DiscountModel.fromApiJson(Map<String, dynamic> json) {
    final meal = json['meal'] as Map?;
    return DiscountModel(
      id: json['id'].toString(),
      cookId: currentCookId,
      mealId: json['mealId']?.toString() ?? '',
      mealName: meal?['name'] as String? ?? '',
      mealImageUrl: meal?['image'] as String? ?? '',
      mealBasePrice: 0,
      discountPercentage: double.tryParse(json['discountPercentage']?.toString() ?? '') ?? 0,
      discountDurationDays: json['discountDuration'] as int? ?? 0,
      usageNumberLimit: json['usageLimit'] as int?,
      usageCount: json['usageCount'] as int? ?? 0,
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
      expiryTime: DateTime.tryParse(json['expireTime']?.toString() ?? '') ?? DateTime.now(),
      status: json['status'] == false ? DiscountStatus.deleted : DiscountStatus.active,
    );
  }

  DiscountEntity toEntity() => DiscountEntity(
        id: id,
        mealId: mealId,
        discountPercentage: discountPercentage,
        discountDurationDays: discountDurationDays,
        usageNumberLimit: usageNumberLimit,
        usageCount: usageCount,
        createdAt: createdAt,
        expiryTime: expiryTime,
        status: status,
      );

  /// Real-shape request body for `POST /user/cook/menu/discounts/create`.
  /// `usage_limit` is omitted entirely when unset — no documented request
  /// example (create or edit) ever shows this key, and this backend is
  /// confirmed elsewhere to 400 on any undocumented property, so a literal
  /// `null` isn't safe to send either.
  Map<String, dynamic> toApiRequestFields() => {
        'meal_id': int.tryParse(mealId) ?? mealId,
        'discount_percentage': discountPercentage,
        'discount_duration': discountDurationDays,
        if (usageNumberLimit != null) 'usage_limit': usageNumberLimit,
      };

  DiscountModel copyWith({
    String? mealName,
    String? mealImageUrl,
    double? mealBasePrice,
    double? discountPercentage,
    int? discountDurationDays,
    DateTime? expiryTime,
    int? usageNumberLimit,
    bool clearUsageNumberLimit = false,
    int? usageCount,
    DiscountStatus? status,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
  }) =>
      DiscountModel(
        id: id,
        cookId: cookId,
        mealId: mealId,
        mealName: mealName ?? this.mealName,
        mealImageUrl: mealImageUrl ?? this.mealImageUrl,
        mealBasePrice: mealBasePrice ?? this.mealBasePrice,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        discountDurationDays: discountDurationDays ?? this.discountDurationDays,
        expiryTime: expiryTime ?? this.expiryTime,
        usageNumberLimit:
            clearUsageNumberLimit ? null : (usageNumberLimit ?? this.usageNumberLimit),
        usageCount: usageCount ?? this.usageCount,
        createdAt: createdAt,
        status: status ?? this.status,
        deletedAt: clearDeletedAt ? null : (deletedAt ?? this.deletedAt),
      );
}
