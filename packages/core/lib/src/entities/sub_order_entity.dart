import 'package:equatable/equatable.dart';

import '../constants/order_status.dart';
import 'order_item_entity.dart';

/// One cook's portion of a multi-cook order — a customer's single Order
/// splits into one SubOrder per cook, each with its own status/expiration.
class SubOrderEntity extends Equatable {
  final String id;
  final String cookId;
  final String cookName;
  final String? cookAvatarUrl;
  final OrderStatus status;
  final DateTime? expirationDate;
  final List<OrderItemEntity> items;

  const SubOrderEntity({
    required this.id,
    required this.cookId,
    required this.cookName,
    required this.status,
    required this.items,
    this.cookAvatarUrl,
    this.expirationDate,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.subtotal);

  @override
  List<Object?> get props =>
      [id, cookId, cookName, cookAvatarUrl, status, expirationDate, items];
}
