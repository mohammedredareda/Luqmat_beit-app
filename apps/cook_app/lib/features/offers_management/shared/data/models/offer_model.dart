import 'package:core/core.dart';

import 'offer_meal_model.dart';

/// [deletedAt] is data-layer-only (CK-15 soft delete) — it is never mapped
/// onto [OfferEntity]; soft-deleted rows are filtered out before an entity
/// is ever built, mirroring `MealModel`'s convention.
class OfferModel {
  const OfferModel({
    required this.id,
    required this.cookId,
    required this.name,
    required this.description,
    required this.totalPrice,
    required this.durationDays,
    required this.createdAt,
    required this.expiryTime,
    this.imageUrl,
    this.includedMeals = const [],
    this.status = OfferStatus.active,
    this.deletedAt,
  });

  final String id;
  final String cookId;
  final String name;
  final String description;
  final double totalPrice;
  final int durationDays;
  final DateTime createdAt;
  final DateTime expiryTime;
  final String? imageUrl;
  final List<OfferMealModel> includedMeals;
  final OfferStatus status;
  final DateTime? deletedAt;

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json['id'] as String,
        cookId: json['cookId'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        totalPrice: (json['totalPrice'] as num).toDouble(),
        durationDays: json['durationDays'] as int,
        createdAt: DateTime.parse(json['createdAt'] as String),
        expiryTime: DateTime.parse(json['expiryTime'] as String),
        imageUrl: json['imageUrl'] as String?,
        includedMeals: (json['includedMeals'] as List<dynamic>? ?? [])
            .map((e) => OfferMealModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: OfferStatus.values.byName(json['status'] as String),
        deletedAt:
            json['deletedAt'] == null ? null : DateTime.parse(json['deletedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cookId': cookId,
        'name': name,
        'description': description,
        'totalPrice': totalPrice,
        'durationDays': durationDays,
        'createdAt': createdAt.toIso8601String(),
        'expiryTime': expiryTime.toIso8601String(),
        'imageUrl': imageUrl,
        'includedMeals': includedMeals.map((m) => m.toJson()).toList(),
        'status': status.name,
        'deletedAt': deletedAt?.toIso8601String(),
      };

  OfferEntity toEntity() => OfferEntity(
        id: id,
        cookId: cookId,
        name: name,
        description: description,
        totalPrice: totalPrice,
        durationDays: durationDays,
        createdAt: createdAt,
        expiryTime: expiryTime,
        status: status,
        meals: includedMeals.map((m) => m.toEntity()).toList(),
      );

  OfferModel copyWith({
    String? name,
    String? description,
    double? totalPrice,
    int? durationDays,
    DateTime? expiryTime,
    String? imageUrl,
    List<OfferMealModel>? includedMeals,
    OfferStatus? status,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
  }) =>
      OfferModel(
        id: id,
        cookId: cookId,
        name: name ?? this.name,
        description: description ?? this.description,
        totalPrice: totalPrice ?? this.totalPrice,
        durationDays: durationDays ?? this.durationDays,
        createdAt: createdAt,
        expiryTime: expiryTime ?? this.expiryTime,
        imageUrl: imageUrl ?? this.imageUrl,
        includedMeals: includedMeals ?? this.includedMeals,
        status: status ?? this.status,
        deletedAt: clearDeletedAt ? null : (deletedAt ?? this.deletedAt),
      );
}
