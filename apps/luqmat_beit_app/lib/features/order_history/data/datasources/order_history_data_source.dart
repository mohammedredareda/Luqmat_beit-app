import 'package:core/core.dart';

abstract class OrderHistoryDataSource {
  Future<List<OrderEntity>> getOrderHistory();

  Future<void> reorder(String orderId);
}
