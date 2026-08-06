import 'package:core/core.dart';

import '../repositories/ratings_repository.dart';

class GetOrderToRate {
  const GetOrderToRate(this._repository);

  final RatingsRepository _repository;

  Future<Result<OrderEntity>> call(String orderId) =>
      _repository.getOrderToRate(orderId);
}
