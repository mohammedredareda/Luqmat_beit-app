import 'package:equatable/equatable.dart';

import 'selling_option_entity.dart';

/// A cook's meal, as returned by the API.
///
/// `isActive` is a plain field the backend computes and returns directly,
/// not a client-side derivation. The harmonization report's 4-factor
/// derived formula (availability window · is_stopped · is_selling_paused ·
/// deleted_at) was never actually implemented in the live schema — the real
/// API exposes the simpler `COOK.isActive AND MEAL.isActive` rule instead.
/// Confirm this against the real backend before wiring a Dio-backed
/// repository against it.
///
/// A meal has either a single [price] OR one-or-more [sellingOptions],
/// never both (CK-07). This is enforced where a [MealEntity] gets built
/// from validated form input (see `meal_form_validator.dart` in
/// `cook_app`), not by the type itself — a stricter sealed-union encoding
/// was judged more machinery than this app's single fake datasource
/// currently warrants.
class MealEntity extends Equatable {
  const MealEntity({
    required this.id,
    required this.cookId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isActive,
    this.price,
    this.sellingOptions = const [],
    this.categoryIds = const [],
    this.isStopped = false,
    this.preorderHours,
  });

  final String id;
  final String cookId;
  final String name;
  final String description;
  final String imageUrl;
  final bool isActive;

  /// Populated only when [sellingOptions] is empty.
  final double? price;

  /// Populated only when [price] is null.
  final List<SellingOptionEntity> sellingOptions;

  final List<String> categoryIds;

  /// CK-24's per-meal "stop accepting" flag — distinct from the cook-level
  /// `isSellingPaused` toggle (CK-10, handled elsewhere).
  final bool isStopped;

  final int? preorderHours;

  bool get hasVariations => sellingOptions.isNotEmpty;

  /// The single price, or the cheapest variation's price when this meal
  /// sells with variations — what list/card UIs should display.
  double get displayPrice => hasVariations
      ? sellingOptions.map((option) => option.price).reduce((a, b) => a < b ? a : b)
      : (price ?? 0);

  @override
  List<Object?> get props => [
        id,
        cookId,
        name,
        description,
        price,
        sellingOptions,
        imageUrl,
        isActive,
        isStopped,
        categoryIds,
        preorderHours,
      ];
}
