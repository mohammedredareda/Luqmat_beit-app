import 'package:equatable/equatable.dart';

import 'order_delivery_method.dart';
import 'order_meal_item_entity.dart';
import 'order_offer_item_entity.dart';
import 'order_returned_meal_item_entity.dart';
import 'order_status.dart';

/// A cook's order (Order Management epic). Single-cook only — the
/// multi-cook/`SUB_ORDER` model was removed, so `cookId` is a direct FK.
/// Items are split across three typed lists mirroring the three
/// `ORDER_*_ITEM` tables rather than one polymorphic line-item list, the
/// same "no union unless truly warranted" call [MealEntity] makes.
class OrderEntity extends Equatable {
  const OrderEntity({
    required this.id,
    required this.cookId,
    required this.customerName,
    required this.deliveryMethod,
    required this.status,
    required this.createdAt,
    required this.totalExpectedTimeMinutes,
    required this.subtotal,
    required this.discount,
    required this.total,
    this.mealItems = const [],
    this.offerItems = const [],
    this.returnedMealItems = const [],
    this.rejectionReason,
  });

  final String id;
  final String cookId;
  final String customerName;
  final OrderDeliveryMethod deliveryMethod;
  final OrderStatus status;
  final DateTime createdAt;

  /// `ORDER."Total expected time"` — precomputed by the customer's checkout,
  /// consumed here only to derive CK-25's pending-timeout deadline.
  final int totalExpectedTimeMinutes;

  final double subtotal;
  final double discount;
  final double total;

  final List<OrderMealItemEntity> mealItems;
  final List<OrderOfferItemEntity> offerItems;
  final List<OrderReturnedMealItemEntity> returnedMealItems;

  /// Non-null only when [status] is [OrderStatus.rejected] (R-10: a
  /// rejected status must never appear without a visible reason).
  final String? rejectionReason;

  /// CK-25: timeout = 25% of [totalExpectedTimeMinutes], counted from
  /// [createdAt]. Derived client-side against the fake datasource — for a
  /// real backend this should be server-authoritative to avoid clock drift.
  DateTime get pendingExpiresAt =>
      createdAt.add(Duration(minutes: (totalExpectedTimeMinutes * 0.25).round()));

  /// Time left before the pending timeout expires, floored at [Duration.zero].
  Duration get remainingPendingTime {
    final diff = pendingExpiresAt.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  bool get isPendingExpired =>
      status == OrderStatus.pending && remainingPendingTime == Duration.zero;

  @override
  List<Object?> get props => [
        id,
        cookId,
        customerName,
        deliveryMethod,
        status,
        createdAt,
        totalExpectedTimeMinutes,
        subtotal,
        discount,
        total,
        mealItems,
        offerItems,
        returnedMealItems,
        rejectionReason,
      ];
}
