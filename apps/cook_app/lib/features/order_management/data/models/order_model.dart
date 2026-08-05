import 'package:core/core.dart';

import 'order_meal_item_model.dart';
import 'order_offer_item_model.dart';
import 'order_returned_meal_item_model.dart';

class OrderModel {
  const OrderModel({
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
  final int totalExpectedTimeMinutes;
  final double subtotal;
  final double discount;
  final double total;
  final List<OrderMealItemModel> mealItems;
  final List<OrderOfferItemModel> offerItems;
  final List<OrderReturnedMealItemModel> returnedMealItems;
  final String? rejectionReason;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as String,
        cookId: json['cookId'] as String,
        customerName: json['customerName'] as String,
        deliveryMethod: OrderDeliveryMethod.values.byName(json['deliveryMethod'] as String),
        status: OrderStatus.values.byName(json['status'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
        totalExpectedTimeMinutes: json['totalExpectedTimeMinutes'] as int,
        subtotal: (json['subtotal'] as num).toDouble(),
        discount: (json['discount'] as num).toDouble(),
        total: (json['total'] as num).toDouble(),
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
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cookId': cookId,
        'customerName': customerName,
        'deliveryMethod': deliveryMethod.name,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'totalExpectedTimeMinutes': totalExpectedTimeMinutes,
        'subtotal': subtotal,
        'discount': discount,
        'total': total,
        'mealItems': mealItems.map((e) => e.toJson()).toList(),
        'offerItems': offerItems.map((e) => e.toJson()).toList(),
        'returnedMealItems': returnedMealItems.map((e) => e.toJson()).toList(),
        'rejectionReason': rejectionReason,
      };

  OrderEntity toEntity() => OrderEntity(
        id: id,
        cookId: cookId,
        customerName: customerName,
        deliveryMethod: deliveryMethod,
        status: status,
        createdAt: createdAt,
        totalExpectedTimeMinutes: totalExpectedTimeMinutes,
        subtotal: subtotal,
        discount: discount,
        total: total,
        mealItems: mealItems.map((e) => e.toEntity()).toList(),
        offerItems: offerItems.map((e) => e.toEntity()).toList(),
        returnedMealItems: returnedMealItems.map((e) => e.toEntity()).toList(),
        rejectionReason: rejectionReason,
      );

  OrderModel copyWith({
    OrderStatus? status,
    String? rejectionReason,
    bool clearRejectionReason = false,
  }) =>
      OrderModel(
        id: id,
        cookId: cookId,
        customerName: customerName,
        deliveryMethod: deliveryMethod,
        status: status ?? this.status,
        createdAt: createdAt,
        totalExpectedTimeMinutes: totalExpectedTimeMinutes,
        subtotal: subtotal,
        discount: discount,
        total: total,
        mealItems: mealItems,
        offerItems: offerItems,
        returnedMealItems: returnedMealItems,
        rejectionReason:
            clearRejectionReason ? null : (rejectionReason ?? this.rejectionReason),
      );
}
