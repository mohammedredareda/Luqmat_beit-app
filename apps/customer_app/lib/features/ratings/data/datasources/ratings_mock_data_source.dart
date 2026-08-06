import 'package:core/core.dart';

import '../../../../shared/mock/sample_catalog.dart';
import 'ratings_data_source.dart';

/// Stands in for `ratings_remote_data_source.dart` until a backend exists.
/// Same call shape a real Dio-backed datasource would have.
class RatingsMockDataSource implements RatingsDataSource {
  @override
  Future<OrderEntity> getOrderToRate(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final meal = SampleCatalog.meals.first;
    final option = meal.sellingOptions.first;
    return OrderEntity(
      id: orderId,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      deliveryAddress: 'رام الله - شارع الإرسال',
      subOrders: [
        SubOrderEntity(
          id: '$orderId-sub-1',
          cookId: meal.cookId,
          cookName: meal.cookName,
          cookAvatarUrl: meal.cookAvatarUrl,
          status: OrderStatus.delivered,
          items: [
            OrderItemEntity(
              id: '$orderId-item-1',
              mealId: meal.id,
              mealName: meal.name,
              mealImageUrl: meal.imageUrl,
              sellingOptionLabel: option.label,
              priceAtPurchase: option.price,
              quantity: 1,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Future<void> submitRating({
    required String orderId,
    required int stars,
    String? review,
    String? mealId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
  }
}
