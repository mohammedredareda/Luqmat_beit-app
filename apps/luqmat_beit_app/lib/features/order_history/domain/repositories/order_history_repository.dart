import 'package:core/core.dart';

/// CU-20/CU-21: past (completed/rejected) orders — distinct from the
/// in-progress "My Orders" list built by another feature.
abstract class OrderHistoryRepository {
  Future<Result<List<OrderEntity>>> getOrderHistory();
}
