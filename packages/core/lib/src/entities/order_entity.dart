import 'package:equatable/equatable.dart';

import 'sub_order_entity.dart';

class OrderEntity extends Equatable {
  final String id;
  final DateTime createdAt;
  final List<SubOrderEntity> subOrders;
  final double deliveryFee;
  final double discountAmount;
  final String deliveryAddress;

  const OrderEntity({
    required this.id,
    required this.createdAt,
    required this.subOrders,
    required this.deliveryAddress,
    this.deliveryFee = 0,
    this.discountAmount = 0,
  });

  double get itemsTotal =>
      subOrders.fold(0, (sum, sub) => sum + sub.subtotal);

  double get grandTotal => itemsTotal + deliveryFee - discountAmount;

  @override
  List<Object?> get props => [
        id,
        createdAt,
        subOrders,
        deliveryFee,
        discountAmount,
        deliveryAddress,
      ];
}
