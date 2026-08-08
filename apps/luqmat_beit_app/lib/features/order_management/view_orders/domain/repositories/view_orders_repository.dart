import 'package:core/core.dart';

abstract class ViewOrdersRepository {
  /// CK-16 — one page of the cook's orders, optionally filtered by
  /// [statusFilter]. A `null` filter returns every order regardless of
  /// status. `cursor: null` requests the first page.
  Future<Result<PaginatedResult<OrderEntity>>> getOrders({
    required String cookId,
    OrderStatus? statusFilter,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  });
}
