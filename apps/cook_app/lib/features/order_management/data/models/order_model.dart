import 'package:core/core.dart';

import 'order_meal_item_model.dart';
import 'order_offer_item_model.dart';
import 'order_returned_meal_item_model.dart';

class OrderModel {
  const OrderModel({
    required this.id,
    required this.cookId,
    required this.cookName,
    required this.customerId,
    required this.status,
    required this.createdAt,
    required this.totalExpectedTimeMinutes,
    required this.deliveryAddress,
    this.customerName,
    this.mealItems = const [],
    this.offerItems = const [],
    this.returnedMealItems = const [],
    this.rejectionReason,
    this.chosenDeliveryTime,
    this.deliveryFee = 0,
    this.discountAmount = 0,
  });

  final String id;
  final String cookId;
  final String cookName;
  final String customerId;
  final String? customerName;
  final OrderStatus status;
  final DateTime createdAt;
  final int totalExpectedTimeMinutes;
  final String deliveryAddress;
  final List<OrderMealItemModel> mealItems;
  final List<OrderOfferItemModel> offerItems;
  final List<OrderReturnedMealItemModel> returnedMealItems;
  final String? rejectionReason;
  final DateTime? chosenDeliveryTime;
  final double deliveryFee;
  final double discountAmount;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as String,
        cookId: json['cookId'] as String,
        cookName: json['cookName'] as String,
        customerId: json['customerId'] as String,
        customerName: json['customerName'] as String?,
        status: OrderStatus.values.byName(json['status'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
        totalExpectedTimeMinutes: json['totalExpectedTimeMinutes'] as int,
        deliveryAddress: json['deliveryAddress'] as String,
        mealItems: (json['mealItems'] as List<dynamic>? ?? [])
            .map((e) => OrderMealItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        offerItems: (json['offerItems'] as List<dynamic>? ?? [])
            .map((e) => OrderOfferItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        returnedMealItems: (json['returnedMealItems'] as List<dynamic>? ?? [])
            .map((e) => OrderReturnedMealItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        rejectionReason: json['rejectionReason'] as String?,
        chosenDeliveryTime: json['chosenDeliveryTime'] == null
            ? null
            : DateTime.parse(json['chosenDeliveryTime'] as String),
        deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0,
        discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cookId': cookId,
        'cookName': cookName,
        'customerId': customerId,
        'customerName': customerName,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'totalExpectedTimeMinutes': totalExpectedTimeMinutes,
        'deliveryAddress': deliveryAddress,
        'mealItems': mealItems.map((e) => e.toJson()).toList(),
        'offerItems': offerItems.map((e) => e.toJson()).toList(),
        'returnedMealItems': returnedMealItems.map((e) => e.toJson()).toList(),
        'rejectionReason': rejectionReason,
        'chosenDeliveryTime': chosenDeliveryTime?.toIso8601String(),
        'deliveryFee': deliveryFee,
        'discountAmount': discountAmount,
      };

  /// CK-25: the pending-order timeout deadline is always 25% of
  /// [totalExpectedTimeMinutes] past [createdAt] — computed fresh here
  /// rather than persisted, since it's a pure function of the two.
  OrderEntity toEntity() => OrderEntity(
        id: id,
        cookId: cookId,
        cookName: cookName,
        customerId: customerId,
        customerName: customerName,
        status: status,
        createdAt: createdAt,
        totalExpectedTimeMinutes: totalExpectedTimeMinutes,
        deliveryAddress: deliveryAddress,
        mealItems: mealItems.map((e) => e.toEntity()).toList(),
        offerItems: offerItems.map((e) => e.toEntity()).toList(),
        returnedMealItems: returnedMealItems.map((e) => e.toEntity()).toList(),
        rejectionReason: rejectionReason,
        pendingExpiresAt: createdAt.add(
          Duration(minutes: (totalExpectedTimeMinutes * 0.25).round()),
        ),
        chosenDeliveryTime: chosenDeliveryTime,
        deliveryFee: deliveryFee,
        discountAmount: discountAmount,
      );

  OrderModel copyWith({
    OrderStatus? status,
    String? rejectionReason,
    bool clearRejectionReason = false,
  }) =>
      OrderModel(
        id: id,
        cookId: cookId,
        cookName: cookName,
        customerId: customerId,
        customerName: customerName,
        status: status ?? this.status,
        createdAt: createdAt,
        totalExpectedTimeMinutes: totalExpectedTimeMinutes,
        deliveryAddress: deliveryAddress,
        mealItems: mealItems,
        offerItems: offerItems,
        returnedMealItems: returnedMealItems,
        rejectionReason:
            clearRejectionReason ? null : (rejectionReason ?? this.rejectionReason),
        chosenDeliveryTime: chosenDeliveryTime,
        deliveryFee: deliveryFee,
        discountAmount: discountAmount,
      );
}
