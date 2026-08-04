import 'package:core/core.dart';

abstract class ViewOrdersRepository {
  /// CK-16 — the cook's orders, optionally filtered by [statusFilter].
  /// A `null` filter returns every order regardless of status.
  Future<Result<List<OrderEntity>>> getOrders({
    required String cookId,
    OrderStatus? statusFilter,
  });
}
