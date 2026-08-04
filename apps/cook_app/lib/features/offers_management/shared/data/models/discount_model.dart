import 'package:core/core.dart';

/// [deletedAt] is data-layer-only (CK-15 soft delete), mirroring
/// `OfferModel`/`MealModel`'s convention.
class DiscountModel {
  const DiscountModel({
    required this.id,
    required this.cookId,
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.mealBasePrice,
    required this.percentage,
    required this.mode,
    required this.isActive,
    required this.createdAt,
    this.durationDays,
    this.usageLimit,
    this.usageCount = 0,
    this.deletedAt,
  });

  final String id;
  final String cookId;
  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final double mealBasePrice;
  final double percentage;
  final DiscountRestrictionMode mode;
  final int? durationDays;
  final int? usageLimit;
  final int usageCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? deletedAt;

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        id: json['id'] as String,
        cookId: json['cookId'] as String,
        mealId: json['mealId'] as String,
        mealName: json['mealName'] as String,
        mealImageUrl: json['mealImageUrl'] as String,
        mealBasePrice: (json['mealBasePrice'] as num).toDouble(),
        percentage: (json['percentage'] as num).toDouble(),
        mode: DiscountRestrictionMode.values.byName(json['mode'] as String),
        durationDays: json['durationDays'] as int?,
        usageLimit: json['usageLimit'] as int?,
        usageCount: json['usageCount'] as int? ?? 0,
        isActive: json['isActive'] as bool,
        createdAt: DateTime.parse(json['createdAt'] as String),
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
        'percentage': percentage,
        'mode': mode.name,
        'durationDays': durationDays,
        'usageLimit': usageLimit,
        'usageCount': usageCount,
        'isActive': isActive,
        'createdAt': createdAt.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
      };

  DiscountEntity toEntity() => DiscountEntity(
        id: id,
        cookId: cookId,
        mealId: mealId,
        mealName: mealName,
        mealImageUrl: mealImageUrl,
        mealBasePrice: mealBasePrice,
        percentage: percentage,
        mode: mode,
        durationDays: durationDays,
        usageLimit: usageLimit,
        usageCount: usageCount,
        isActive: isActive,
        createdAt: createdAt,
      );

  DiscountModel copyWith({
    String? mealName,
    String? mealImageUrl,
    double? mealBasePrice,
    double? percentage,
    DiscountRestrictionMode? mode,
    int? durationDays,
    bool clearDurationDays = false,
    int? usageLimit,
    bool clearUsageLimit = false,
    int? usageCount,
    bool? isActive,
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
        percentage: percentage ?? this.percentage,
        mode: mode ?? this.mode,
        durationDays: clearDurationDays ? null : (durationDays ?? this.durationDays),
        usageLimit: clearUsageLimit ? null : (usageLimit ?? this.usageLimit),
        usageCount: usageCount ?? this.usageCount,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt,
        deletedAt: clearDeletedAt ? null : (deletedAt ?? this.deletedAt),
      );
}
