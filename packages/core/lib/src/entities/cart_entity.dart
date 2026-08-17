import 'package:equatable/equatable.dart';

import 'cart_cook_group_entity.dart';
import 'cart_returned_meal_item_entity.dart';

/// The customer's whole cart — one section per cook (see
/// [CartCookGroupEntity]) plus returned-meal ("من نصيبك") lines, which the
/// backend returns ungrouped (not attached to any one cook).
class CartEntity extends Equatable {
  final String customerId;
  final List<CartCookGroupEntity> cookGroups;
  final List<CartReturnedMealItemEntity> returnedMealItems;

  const CartEntity({
    required this.customerId,
    this.cookGroups = const [],
    this.returnedMealItems = const [],
  });

  bool get isEmpty =>
      cookGroups.every((g) => g.isEmpty) && returnedMealItems.isEmpty;

  double get itemsTotal =>
      cookGroups.fold(0.0, (sum, g) => sum + g.subtotal) +
      returnedMealItems.fold(0.0, (sum, i) => sum + i.subtotal);

  @override
  List<Object?> get props => [customerId, cookGroups, returnedMealItems];
}
