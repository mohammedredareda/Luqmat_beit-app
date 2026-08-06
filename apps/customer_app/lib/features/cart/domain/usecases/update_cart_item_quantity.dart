import 'package:core/core.dart';

import '../repositories/cart_repository.dart';

class UpdateCartItemQuantity {
  const UpdateCartItemQuantity(this._repository);

  final CartRepository _repository;

  Future<Result<void>> call(String cartItemId, int quantity) =>
      _repository.updateQuantity(cartItemId, quantity);
}
