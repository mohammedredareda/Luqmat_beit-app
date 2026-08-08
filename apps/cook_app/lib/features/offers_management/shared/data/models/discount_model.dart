import 'package:core/core.dart';

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
