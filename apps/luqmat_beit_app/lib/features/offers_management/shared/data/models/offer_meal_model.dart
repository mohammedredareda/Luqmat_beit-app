import 'package:core/core.dart';

/// Data-layer offer-line row — carries pricing/selling-option fields the
/// create/edit-offer form needs even though [OfferMealEntity] (the shared
/// domain shape) only has `mealId`/`mealName`/`mealImageUrl`/
/// `variationQuantity`.
class OfferMealModel {
  const OfferMealModel({
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.unitPrice,
    required this.quantity,
    this.sellingOptionId,
    this.sellingOptionLabel,
  });

  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final String? sellingOptionId;
  final String? sellingOptionLabel;
  final double unitPrice;
  final int quantity;

  /// Real-shape response parsing from `GET /user/cook/menu/offers/{id}`'s
  /// `offerMeals[]` — only a free-text `variationQuantity` (not a
  /// decomposed unit price/quantity/selling-option) and a nested
  /// `meal:{name,image}`. [unitPrice]/[quantity]/[sellingOptionId] have no
  /// real source here — default to 0/1/null so the edit form can still
  /// render the included meal's name/image/description; the cook would
  /// need to re-pick a selling option to change a per-meal quantity via
  /// the stepper UI (see `EditOfferBloc.mealQuantityIncremented`, which
  /// only mutates [quantity] locally, never round-trips it to the API on
  /// its own — the whole `variationQuantity` string is rebuilt on submit).
  factory OfferMealModel.fromApiJson(Map<String, dynamic> json) {
    final meal = json['meal'] as Map?;
    return OfferMealModel(
      mealId: json['mealId'].toString(),
      mealName: meal?['name'] as String? ?? '',
      mealImageUrl: meal?['image'] as String? ?? '',
      sellingOptionLabel: json['variationQuantity'] as String?,
      unitPrice: 0,
      quantity: 1,
    );
  }

  factory OfferMealModel.fromJson(Map<String, dynamic> json) => OfferMealModel(
        mealId: json['mealId'] as String,
        mealName: json['mealName'] as String,
        mealImageUrl: json['mealImageUrl'] as String,
        sellingOptionId: json['sellingOptionId'] as String?,
        sellingOptionLabel: json['sellingOptionLabel'] as String?,
        unitPrice: (json['unitPrice'] as num).toDouble(),
        quantity: json['quantity'] as int,
      );

  Map<String, dynamic> toJson() => {
        'mealId': mealId,
        'mealName': mealName,
        'mealImageUrl': mealImageUrl,
        'sellingOptionId': sellingOptionId,
        'sellingOptionLabel': sellingOptionLabel,
        'unitPrice': unitPrice,
        'quantity': quantity,
      };

  OfferMealEntity toEntity() => OfferMealEntity(
        mealId: mealId,
        mealName: mealName,
        mealImageUrl: mealImageUrl,
        variationQuantity: quantity,
      );

  /// Real API request shape for `POST/PUT .../offers/...`'s `meals` array.
  /// The live endpoint wants one free-text `variation_quantity` string per
  /// meal (e.g. `"حجم عائلي"`, `"نصف دجاجة"`) — no separate quantity
  /// multiplier field — so [quantity] > 1 is folded into that same string
  /// rather than dropped.
  Map<String, dynamic> toApiJson() => {
        'meal_id': int.tryParse(mealId) ?? mealId,
        'variation_quantity': _variationQuantity,
      };

  String get _variationQuantity {
    final base = sellingOptionLabel ?? '';
    if (quantity <= 1) return base;
    return base.isEmpty ? '${quantity}x' : '${quantity}x $base';
  }
}
