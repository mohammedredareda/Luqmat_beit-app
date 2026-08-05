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
    required this.isActive,
    required this.createdAt,
    this.imageUrl,
    this.includedMeals = const [],
    this.deletedAt,
  });

  final String id;
  final String cookId;
  final String name;
  final String description;
  final double totalPrice;
  final int durationDays;
  final bool isActive;
  final DateTime createdAt;
  final String? imageUrl;
  final List<OfferMealModel> includedMeals;
  final DateTime? deletedAt;

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json['id'] as String,
        cookId: json['cookId'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        totalPrice: (json['totalPrice'] as num).toDouble(),
        durationDays: json['durationDays'] as int,
        isActive: json['isActive'] as bool,
        createdAt: DateTime.parse(json['createdAt'] as String),
        imageUrl: json['imageUrl'] as String?,
        includedMeals: (json['includedMeals'] as List<dynamic>? ?? [])
            .map((e) => OfferMealModel.fromJson(e as Map<String, dynamic>))
            .toList(),
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
        'isActive': isActive,
        'createdAt': createdAt.toIso8601String(),
        'imageUrl': imageUrl,
        'includedMeals': includedMeals.map((m) => m.toJson()).toList(),
        'deletedAt': deletedAt?.toIso8601String(),
      };

  OfferEntity toEntity() => OfferEntity(
        id: id,
        cookId: cookId,
        name: name,
        description: description,
        totalPrice: totalPrice,
        durationDays: durationDays,
        isActive: isActive,
        createdAt: createdAt,
        imageUrl: imageUrl,
        includedMeals: includedMeals.map((m) => m.toEntity()).toList(),
      );

  OfferModel copyWith({
    String? name,
    String? description,
    double? totalPrice,
    int? durationDays,
    bool? isActive,
    String? imageUrl,
    List<OfferMealModel>? includedMeals,
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
        isActive: isActive ?? this.isActive,
        createdAt: createdAt,
        imageUrl: imageUrl ?? this.imageUrl,
        includedMeals: includedMeals ?? this.includedMeals,
        deletedAt: clearDeletedAt ? null : (deletedAt ?? this.deletedAt),
      );
}
