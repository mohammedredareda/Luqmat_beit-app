import 'package:core/core.dart';

/// CU-22 — the "Delivery Receipt" screen: fetch a just-delivered order so
/// the customer can either confirm receipt or dispute it with a reason.
abstract class DeliveryRepository {
  Future<Result<OrderEntity>> getDeliveredOrder(String orderId);

  Future<Result<void>> confirmReceipt(String orderId);

  Future<Result<void>> reportIssue(String orderId, String reason);
}
