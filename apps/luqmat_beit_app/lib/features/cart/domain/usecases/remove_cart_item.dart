import 'package:core/core.dart';

import '../repositories/cart_repository.dart';

class RemoveCartItem {
  const RemoveCartItem(this._repository);

  final CartRepository _repository;

  Future<Result<void>> call(String cartItemId) => _repository.removeItem(cartItemId);
}
