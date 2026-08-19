import 'package:core/core.dart';

import '../../../../shared/mock/sample_catalog.dart';
import 'order_history_data_source.dart';

/// Stands in for `order_history_remote_data_source.dart` until a backend
/// exists. Same call shape a real Dio-backed datasource would have, so
/// swapping it in later doesn't touch the repository.
class OrderHistoryMockDataSource implements OrderHistoryDataSource {
  @override
  Future<List<OrderEntity>> getOrderHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final meal1 = SampleCatalog.mealById('meal-1');
    final meal2 = SampleCatalog.mealById('meal-2');
    final meal3 = SampleCatalog.mealById('meal-3');
    final meal4 = SampleCatalog.mealById('meal-4');

    return [
      OrderEntity(
        id: 'order-h1',
        cookId: meal1.cookId,
        cookName: meal1.cookName,
        cookAvatarUrl: meal1.cookAvatarUrl,
        customerId: 'customer-1',
        createdAt: DateTime(2026, 6, 15),
        status: OrderStatus.delivered,
        deliveryAddress: 'شارع الياسمين، حيفا',
        deliveryFee: 10,
        totalExpectedTimeMinutes: 40,
        mealItems: [
          OrderMealItemEntity(
            id: 'item-h1-1',
            mealId: meal1.id,
            mealName: meal1.name,
            mealImageUrl: meal1.imageUrl,
            sellingOptionLabel: meal1.sellingOptions.first.label,
            priceAtPurchase: meal1.sellingOptions.first.price,
            quantity: 1,
          ),
        ],
      ),
      OrderEntity(
        id: 'order-h2',
        cookId: meal2.cookId,
        cookName: meal2.cookName,
        cookAvatarUrl: meal2.cookAvatarUrl,
        customerId: 'customer-1',
        createdAt: DateTime(2026, 6, 10),
        status: OrderStatus.delivered,
        deliveryAddress: 'شارع الياسمين، حيفا',
        deliveryFee: 10,
        totalExpectedTimeMinutes: 40,
        mealItems: [
          OrderMealItemEntity(
            id: 'item-h2-1',
            mealId: meal2.id,
            mealName: meal2.name,
            mealImageUrl: meal2.imageUrl,
            sellingOptionLabel: meal2.sellingOptions.first.label,
            priceAtPurchase: meal2.sellingOptions.first.price,
            quantity: 2,
          ),
        ],
      ),
      OrderEntity(
        id: 'order-h3',
        cookId: meal3.cookId,
        cookName: meal3.cookName,
        customerId: 'customer-1',
        createdAt: DateTime(2026, 6, 1),
        status: OrderStatus.delivered,
        deliveryAddress: 'شارع الياسمين، حيفا',
        deliveryFee: 10,
        discountAmount: 5,
        totalExpectedTimeMinutes: 30,
        mealItems: [
          OrderMealItemEntity(
            id: 'item-h3-1',
            mealId: meal3.id,
            mealName: meal3.name,
            mealImageUrl: meal3.imageUrl,
            sellingOptionLabel: meal3.sellingOptions.first.label,
            priceAtPurchase: meal3.sellingOptions.first.price,
            quantity: 1,
          ),
        ],
      ),
      OrderEntity(
        id: 'order-h4',
        cookId: meal4.cookId,
        cookName: meal4.cookName,
        customerId: 'customer-1',
        createdAt: DateTime(2026, 5, 28),
        status: OrderStatus.rejected,
        rejectionReason: 'الطباخة غير متاحة حالياً.',
        deliveryAddress: 'شارع الياسمين، حيفا',
        deliveryFee: 10,
        totalExpectedTimeMinutes: 35,
        mealItems: [
          OrderMealItemEntity(
            id: 'item-h4-1',
            mealId: meal4.id,
            mealName: meal4.name,
            mealImageUrl: meal4.imageUrl,
            sellingOptionLabel: meal4.sellingOptions.first.label,
            priceAtPurchase: meal4.sellingOptions.first.price,
            quantity: 1,
          ),
        ],
      ),
    ];
  }

  @override
  Future<void> reorder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
