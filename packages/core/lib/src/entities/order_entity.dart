import 'package:equatable/equatable.dart';

import '../constants/order_status.dart';
import 'order_meal_item_entity.dart';
import 'order_offer_item_entity.dart';
import 'order_returned_meal_item_entity.dart';

/// A single-cook order — the multi-cook/`SUB_ORDER` model was removed "for
/// now" per the updated backlog's Project Fixes doc, so `cookId` is a direct
/// FK and items are split across three typed line-item lists instead of a
/// generic item type.
class OrderEntity extends Equatable {
  final String id;
  final String cookId;
  final String cookName;
  final String? cookAvatarUrl;
  final String customerId;
  final String? customerName;
  final DateTime createdAt;
  final OrderStatus status;
  final List<OrderMealItemEntity> mealItems;
  final List<OrderOfferItemEntity> offerItems;
  final List<OrderReturnedMealItemEntity> returnedMealItems;

  /// Average of the expected prep time across every item, computed at
  /// checkout — also the basis for the pending-timeout deadline (25% of
  /// this value, see [pendingExpiresAt]).
  final int totalExpectedTimeMinutes;

  /// The computed Pending-order timeout deadline. Only meaningful while
  /// [status] is [OrderStatus.pending].
  final DateTime? pendingExpiresAt;

  /// Mandatory free-text reason captured on cook rejection — null unless
  /// [status] is [OrderStatus.rejected].
  final String? rejectionReason;

  final String deliveryAddress;

  /// Null means "deliver immediately"; otherwise a scheduled time that must
  /// fall within the cook's availability window.
  final DateTime? chosenDeliveryTime;

  final double deliveryFee;
  final double discountAmount;

  const OrderEntity({
    required this.id,
    required this.cookId,
    required this.cookName,
    required this.customerId,
    required this.createdAt,
    required this.status,
    required this.deliveryAddress,
    required this.totalExpectedTimeMinutes,
    this.cookAvatarUrl,
    this.customerName,
    this.mealItems = const [],
    this.offerItems = const [],
    this.returnedMealItems = const [],
    this.pendingExpiresAt,
    this.rejectionReason,
    this.chosenDeliveryTime,
    this.deliveryFee = 0,
    this.discountAmount = 0,
  });

  double get itemsTotal =>
      mealItems.fold(0.0, (sum, i) => sum + i.subtotal) +
      offerItems.fold(0.0, (sum, i) => sum + i.subtotal) +
      returnedMealItems.fold(0.0, (sum, i) => sum + i.subtotal);

  double get grandTotal => itemsTotal + deliveryFee - discountAmount;

  /// The cook's own share of [grandTotal] — the delivery fee is passed
  /// through to delivery, not earned by the cook, so cook-facing order
  /// previews must never show it blended into a single "total" figure.
  double get cookTotal => grandTotal - deliveryFee;

  bool get isPendingExpired =>
      status == OrderStatus.pending &&
      pendingExpiresAt != null &&
      DateTime.now().isAfter(pendingExpiresAt!);

  @override
  List<Object?> get props => [
        id,
        cookId,
        cookName,
        cookAvatarUrl,
        customerId,
        customerName,
        createdAt,
        status,
        mealItems,
        offerItems,
        returnedMealItems,
        totalExpectedTimeMinutes,
        pendingExpiresAt,
        rejectionReason,
        deliveryAddress,
        chosenDeliveryTime,
        deliveryFee,
        discountAmount,
      ];
}
