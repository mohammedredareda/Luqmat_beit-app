import 'package:core/core.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import 'selling_option_model.dart';

/// `isActive` is always derived (CK-24's formula, `MealEntity.computeIsActive`)
/// from [isStopped] + the cook's kitchen-wide pause + availability window —
/// there is no separate intrinsic-active flag to store here.
///
/// [deletedAt] is data-layer-only (CK-09 soft delete) — it is never mapped
/// onto [MealEntity]; soft-deleted rows are filtered out before an entity
/// is ever built, so domain/presentation code never sees this field.
class MealModel {
  const MealModel({
    required this.id,
    required this.cookId,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.price,
    this.sellingOptions = const [],
    this.categoryIds = const [],
    this.isStopped = false,
    this.preorderHours,
    this.deletedAt,
  });

  final String id;
  final String cookId;
  final String name;
  final String description;
  final String imageUrl;
  final double? price;
  final List<SellingOptionModel> sellingOptions;
  final List<String> categoryIds;
  final bool isStopped;
  final int? preorderHours;
  final DateTime? deletedAt;

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
        id: json['id'] as String,
        cookId: json['cookId'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        imageUrl: json['imageUrl'] as String,
        price: (json['price'] as num?)?.toDouble(),
        sellingOptions: (json['sellingOptions'] as List<dynamic>? ?? [])
            .map((e) => SellingOptionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        categoryIds: (json['categoryIds'] as List<dynamic>? ?? []).cast<String>(),
        isStopped: json['isStopped'] as bool? ?? false,
        preorderHours: json['preorderHours'] as int?,
        deletedAt:
            json['deletedAt'] == null ? null : DateTime.parse(json['deletedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cookId': cookId,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'price': price,
        'sellingOptions': sellingOptions.map((o) => o.toJson()).toList(),
        'categoryIds': categoryIds,
        'isStopped': isStopped,
        'preorderHours': preorderHours,
        'deletedAt': deletedAt?.toIso8601String(),
      };

  MealEntity toEntity() => MealEntity(
        id: id,
        cookId: cookId,
        cookName: currentCookName,
        name: name,
        description: description,
        imageUrl: imageUrl,
        singlePrice: price,
        sellingOptions: sellingOptions.map((o) => o.toEntity()).toList(),
        categoryIds: categoryIds,
        isStopped: isStopped,
        preparingDurationMinutes: preorderHours ?? 0,
      );

  MealModel copyWith({
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    bool clearPrice = false,
    List<SellingOptionModel>? sellingOptions,
    bool? isStopped,
    List<String>? categoryIds,
    int? preorderHours,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
  }) =>
      MealModel(
        id: id,
        cookId: cookId,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        price: clearPrice ? null : (price ?? this.price),
        sellingOptions: sellingOptions ?? this.sellingOptions,
        categoryIds: categoryIds ?? this.categoryIds,
        isStopped: isStopped ?? this.isStopped,
        preorderHours: preorderHours ?? this.preorderHours,
        deletedAt: clearDeletedAt ? null : (deletedAt ?? this.deletedAt),
      );
}
