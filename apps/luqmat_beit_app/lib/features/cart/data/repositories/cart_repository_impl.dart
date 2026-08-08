import 'package:core/core.dart';

import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_data_source.dart';
import '../datasources/cart_mock_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({CartDataSource? dataSource})
      : _dataSource = dataSource ?? CartMockDataSource();

  final CartDataSource _dataSource;

  @override
  Future<Result<CartEntity>> getCart() {
    return guard(() => _dataSource.getCart());
  }

  @override
  Future<Result<void>> addItem({
    required MealEntity meal,
    required SellingOptionEntity sellingOption,
    required int quantity,
    String? note,
  }) {
    return guard(() => _dataSource.addItem(
          meal: meal,
          sellingOption: sellingOption,
          quantity: quantity,
          note: note,
        ));
  }

  @override
  Future<Result<void>> updateQuantity(String cartItemId, int quantity) {
    return guard(() => _dataSource.updateQuantity(cartItemId, quantity));
  }

  @override
  Future<Result<void>> removeItem(String cartItemId) {
    return guard(() => _dataSource.removeItem(cartItemId));
  }

  @override
  Future<Result<void>> updateSellingOption(String cartItemId, String sellingOptionId) {
    return guard(() => _dataSource.updateSellingOption(cartItemId, sellingOptionId));
  }
}
