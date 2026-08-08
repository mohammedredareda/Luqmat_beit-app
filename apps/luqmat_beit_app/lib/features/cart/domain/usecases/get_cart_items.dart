import 'package:core/core.dart';

import '../repositories/cart_repository.dart';

class GetCartItems {
  const GetCartItems(this._repository);

  final CartRepository _repository;

  Future<Result<CartEntity>> call() => _repository.getCart();
}
