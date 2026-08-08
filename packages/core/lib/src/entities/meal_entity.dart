import 'package:equatable/equatable.dart';

import 'selling_option_entity.dart';

/// `isActive` is explicitly a derived, never-directly-written value — both
/// apps must call [computeIsActive] rather than duplicating this rule.
class MealEntity extends Equatable {
  final String id;
  final String cookId;
  final String cookName;
  final String? cookAvatarUrl;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int ratingCount;
  final bool isStopped;
  final DateTime? deletedAt;
  final List<SellingOptionEntity> sellingOptions;
  final List<String> tags;

  /// CK-07: a meal has either a single direct price OR one-to-many
  /// [sellingOptions] variations — never both. Null / ignored when
  /// [sellingOptions] is non-empty.
  final double? singlePrice;

  /// Expected preparing duration, in minutes (CK-07).
  final int preparingDurationMinutes;

  final List<String> categoryIds;

  const MealEntity({
    required this.id,
    required this.cookId,
    required this.cookName,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.sellingOptions,
    this.cookAvatarUrl,
    this.rating = 0,
    this.ratingCount = 0,
    this.isStopped = false,
    this.deletedAt,
    this.tags = const [],
    this.singlePrice,
    this.preparingDurationMinutes = 0,
    this.categoryIds = const [],
  });

  bool get hasVariations => sellingOptions.isNotEmpty;

  double get startingPrice => sellingOptions.isEmpty
      ? (singlePrice ?? 0)
      : sellingOptions.map((o) => o.price).reduce((a, b) => a < b ? a : b);

  /// See §7 of the architecture doc — cook availability window and
  /// selling-pause state live on the owning cook, not duplicated here.
  bool computeIsActive({
    required bool withinAvailabilityWindow,
    required bool cookIsSellingPaused,
  }) {
    if (deletedAt != null) return false;
    return withinAvailabilityWindow && !isStopped && !cookIsSellingPaused;
  }

  @override
  List<Object?> get props => [
        id,
        cookId,
        cookName,
        cookAvatarUrl,
        name,
        description,
        imageUrl,
        rating,
        ratingCount,
        isStopped,
        deletedAt,
        sellingOptions,
        tags,
        singlePrice,
        preparingDurationMinutes,
        categoryIds,
      ];
}
