import 'dart:convert';

import 'package:core/core.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'selling_option_model.dart';

/// Real API "Add/Edit meal" has no bare single-price field — every meal is
/// modeled as one-or-more selling options. When the form collects a single
/// flat [MealModel.price] (CK-07's XOR: price OR variations, never both),
/// the request synthesizes exactly one selling option under this label
/// rather than losing the price. Chosen over adding a UI field for this,
/// since the create/edit forms only ever offer "one price" or "N labeled
/// variations," never "one price with an explicit label."
const String singlePriceVariationLabel = 'عادي';

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

  /// Real-shape response parsing from `POST/PUT .../meals/...` and
  /// `GET .../meals` — nested `categories:[{categoryId}]` and
  /// `sellingOptions:[{id,type,variation,price}]`, `image` (not
  /// `imageUrl`), `isActive` (not `isStopped` — inverted), `expectedPrepTime`
  /// as `"HH:MM"` (not the decimal-hours string the write side sends).
  factory MealModel.fromApiJson(Map<String, dynamic> json) {
    final categoriesJson = json['categories'] as List<dynamic>? ?? const [];
    final sellingOptionsJson = json['sellingOptions'] as List<dynamic>? ?? const [];
    return MealModel(
      id: json['id'].toString(),
      cookId: json['cookId']?.toString() ?? currentCookId,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
      sellingOptions: sellingOptionsJson
          .map((o) => SellingOptionModel.fromApiJson(o as Map<String, dynamic>))
          .toList(),
      categoryIds: categoriesJson
          .map((c) => (c as Map<String, dynamic>)['categoryId'].toString())
          .toList(),
      isStopped: json['isActive'] == false,
      preorderHours: _parseExpectedPrepTime(json['expectedPrepTime']),
      deletedAt:
          json['deletedAt'] == null ? null : DateTime.tryParse(json['deletedAt'] as String),
    );
  }

  /// `"HH:MM"` → whole hours, rounding the minutes component — the
  /// preorder-time field only ever collects whole hours from the cook (see
  /// `MealPreorderTimeField`), so this keeps read-then-reopen round-trips
  /// showing the same number rather than an inflated minute count.
  static int? _parseExpectedPrepTime(dynamic value) {
    if (value is! String) return null;
    final parts = value.split(':');
    if (parts.length != 2) return int.tryParse(value);
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    return hours + (minutes >= 30 ? 1 : 0);
  }

  /// The selling options actually sent to the API — synthesizes a single
  /// [singlePriceVariationLabel] option when the form used a flat [price]
  /// instead of variations (see that constant's doc comment).
  List<SellingOptionModel> get effectiveSellingOptions => sellingOptions.isNotEmpty
      ? sellingOptions
      : [SellingOptionModel(id: 'single', label: singlePriceVariationLabel, price: price ?? 0)];

  /// Real-shape multipart request fields for `POST/PUT .../meals/...`
  /// (everything but `image`, which the data source attaches separately as
  /// a `MultipartFile` since it may be a local path or, on a no-image-
  /// change edit, absent entirely).
  Map<String, dynamic> toApiRequestFields() => {
        'name': name,
        'description': description,
        'expectedPrepTime': (preorderHours ?? 0).toString(),
        'categoryIds': jsonEncode(categoryIds.map(int.parse).toList()),
        'sellingOptions': jsonEncode(effectiveSellingOptions.map((o) => o.toApiJson()).toList()),
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
