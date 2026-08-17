import 'dart:convert';

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

  /// Real-shape response parsing from `GET /user/cook/menu/offers/{id}` —
  /// `image` (not `imageUrl`), `duration`/`expireTime` (not
  /// `durationDays`/`expiryTime`), `totalPrice` as a numeric string,
  /// `status` as a bool, and meals nested under `offerMeals`.
  factory OfferModel.fromApiJson(Map<String, dynamic> json) {
    final mealsJson = json['offerMeals'] as List<dynamic>? ?? const [];
    return OfferModel(
      id: json['id'].toString(),
      cookId: json['cookId']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      totalPrice: double.tryParse(json['totalPrice']?.toString() ?? '') ?? 0,
      durationDays: json['duration'] as int? ?? 0,
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
      expiryTime: DateTime.tryParse(json['expireTime']?.toString() ?? '') ?? DateTime.now(),
      imageUrl: json['image'] as String?,
      includedMeals: mealsJson
          .map((m) => OfferMealModel.fromApiJson((m as Map).cast<String, dynamic>()))
          .toList(),
      status: json['status'] == false ? OfferStatus.deleted : OfferStatus.active,
    );
  }

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

  /// Real-shape multipart request fields for `POST/PUT .../offers/...`
  /// (everything but `image`, which the data source attaches separately as
  /// a `MultipartFile`).
  Map<String, dynamic> toApiRequestFields() => {
        'name': name,
        'description': description,
        'total_price': totalPrice.toString(),
        'duration': durationDays.toString(),
        'meals': jsonEncode(includedMeals.map((m) => m.toApiJson()).toList()),
      };

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
