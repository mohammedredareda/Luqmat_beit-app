import 'package:core/core.dart';

import '../models/order_model.dart';

/// Real Dio-backed data source for the Cook Order Management endpoints —
/// replaces `FakeOrderRemoteDataSource`.
class OrderRemoteDataSource {
  OrderRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  /// `GET /user/cook/orders?status=&page=`. The docs' own schema for this
  /// response is a placeholder (`{orders:[...preview infos]}`) — this
  /// defensively accepts either a `data` list with a `meta` envelope
  /// (matching the confirmed `my-promotions`/meals shape) or a flat
  /// `orders` list, falling back to inferring `hasNextPage` from a full
  /// page when no `meta` is present.
  Future<PaginatedResult<OrderModel>> getOrders({
    required String cookId,
    OrderStatus? statusFilter,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) async {
    final page = cursor == null ? 1 : int.parse(cursor);
    final response = await _apiClient.get(
      '/user/cook/orders',
      queryParameters: {
        'page': page,
        if (statusFilter != null) 'status': _statusFilterParam(statusFilter),
      },
    ) as Map;

    final rawList = response['data'] ?? response['orders'];
    final ordersJson = rawList is List ? rawList : const [];
    final orders = ordersJson
        .map((o) => OrderModel.fromApiJson((o as Map).cast<String, dynamic>()))
        .toList();

    final meta = response['meta'] as Map?;
    final hasNextPage =
        meta != null ? (meta['hasNextPage'] as bool? ?? false) : orders.length >= pageSize;

    return PaginatedResult(
      items: orders,
      hasMore: hasNextPage,
      nextCursor: hasNextPage ? (page + 1).toString() : null,
    );
  }

  Future<OrderModel?> getOrderById(String id) async {
    final response = await _apiClient.get('/user/cook/orders/$id') as Map;
    final data = response['data'];
    if (data is! Map) return null;
    return OrderModel.fromApiJson(data.cast<String, dynamic>());
  }

  /// `PATCH .../orders/{id}/accept`. The success-response shape isn't
  /// documented (only a 409-already-expired example exists), so this
  /// re-fetches the order afterward rather than guessing at a payload —
  /// the 409 Conflict itself (CK-25's expiry race) surfaces through the
  /// existing `AppException`/`mapDioException` path unchanged.
  Future<OrderModel> acceptOrder(String id) async {
    await _apiClient.patch('/user/cook/orders/$id/accept');
    return _requireOrder(id);
  }

  /// Confirmed against the live API docs: the body field is `rejectionReason`
  /// (not `reason`) and the backend expects it present on every reject call.
  /// Product decision: the cook is no longer required to *give* one, so
  /// [reason] is optional here — a fixed placeholder is sent in its place
  /// when absent, satisfying the backend without the cook ever seeing or
  /// typing anything. [reason] is kept as a parameter (rather than removed)
  /// so a cook-entered reason can be reinstated later without touching this
  /// call chain.
  Future<OrderModel> rejectOrder({required String id, String? reason}) async {
    final trimmed = reason?.trim();
    await _apiClient.patch(
      '/user/cook/orders/$id/reject',
      data: {
        'rejectionReason':
            trimmed != null && trimmed.isNotEmpty ? trimmed : _noReasonGivenPlaceholder,
      },
    );
    return _requireOrder(id);
  }

  static const _noReasonGivenPlaceholder = 'لم يقدم الطباخ سبباً للرفض';

  Future<OrderModel> completeOrder(String id) async {
    await _apiClient.patch('/user/cook/orders/$id/done');
    return _requireOrder(id);
  }

  Future<OrderModel> _requireOrder(String id) async {
    final order = await getOrderById(id);
    if (order == null) throw const NotFoundException('Order not found');
    return order;
  }

  /// The docs' own filter-value list has a typo ("prearing" for
  /// "preparing") that a previous version of this method copied verbatim
  /// — confirmed live against the server to be wrong (400 "invalid order
  /// status"). Every real status value is just its enum name upper-cased
  /// (`preparing` → `PREPARING`, `delivering` → `DELIVERING`, etc.), so
  /// there's no reason to hardcode any of them individually.
  String _statusFilterParam(OrderStatus status) => status.name.toUpperCase();
}
