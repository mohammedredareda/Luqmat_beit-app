import 'package:core/core.dart';

abstract class OrderDetailsRepository {
  /// CK-17 — full details of one order.
  Future<Result<OrderEntity>> getOrder(String orderId);

  /// CK-18 Accept. Only valid from `pending`; returns the updated order
  /// (now `preparing`). See CK-25 for the expired-pending failure mode.
  Future<Result<OrderEntity>> acceptOrder(String orderId);

  /// CK-18 Reject. Only valid from `pending`; returns the updated order
  /// (now `rejected`). [reason] is optional — the cook is not required to
  /// give one; kept as a parameter rather than removed so it can be
  /// reinstated without touching this call chain.
  Future<Result<OrderEntity>> rejectOrder({required String orderId, String? reason});

  /// CK-19 Complete. Only valid from `preparing`; returns the updated
  /// order (now `done`).
  Future<Result<OrderEntity>> completeOrder(String orderId);
}
