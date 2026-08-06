import 'package:core/core.dart';

import '../../../../shared/mock/sample_catalog.dart';

/// Stands in for `delivery_remote_data_source.dart` until a backend
/// exists. Same call shape a real Dio-backed datasource would have, so
/// swapping it in later doesn't touch the repository.
///
/// TODO(backend): the collection only has a delivery-price *calculator*
/// (`POST /user/customer/order/delivery-price`, unrelated to this feature's
/// accept/confirm-receipt/report-issue flow) — no accept, confirm-receipt,
/// or report-issue endpoints exist yet.
class DeliveryMockDataSource {
  Future<OrderEntity> getDeliveredOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final mainMeal = SampleCatalog.mealById('meal-1');
    final sideMeal = SampleCatalog.mealById('meal-2');

    return OrderEntity(
      id: orderId,
      createdAt: DateTime.now().subtract(const Duration(minutes: 35)),
      deliveryAddress: 'شارع الرينبو، جبل عمّان، عمّان',
      deliveryFee: 2,
      subOrders: [
        SubOrderEntity(
          id: 'sub-$orderId',
          cookId: mainMeal.cookId,
          cookName: mainMeal.cookName,
          cookAvatarUrl: mainMeal.cookAvatarUrl,
          status: OrderStatus.delivered,
          items: [
            OrderItemEntity(
              id: '$orderId-item-1',
              mealId: mainMeal.id,
              mealName: mainMeal.name,
              mealImageUrl: mainMeal.imageUrl,
              sellingOptionLabel: mainMeal.sellingOptions.first.label,
              priceAtPurchase: mainMeal.sellingOptions.first.price,
              quantity: 2,
            ),
            OrderItemEntity(
              id: '$orderId-item-2',
              mealId: sideMeal.id,
              mealName: sideMeal.name,
              mealImageUrl: sideMeal.imageUrl,
              sellingOptionLabel: sideMeal.sellingOptions.first.label,
              priceAtPurchase: sideMeal.sellingOptions.first.price,
              quantity: 1,
            ),
          ],
        ),
      ],
    );
  }

  /// No real fulfilment backend yet — a mock that always "succeeds".
  Future<void> confirmReceipt(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  /// No real support/dispute backend yet — a mock that always "succeeds".
  Future<void> reportIssue(String orderId, String reason) async {
    await Future.delayed(const Duration(milliseconds: 800));
  }
}
