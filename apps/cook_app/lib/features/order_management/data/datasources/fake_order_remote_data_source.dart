import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../models/order_meal_item_model.dart';
import '../models/order_model.dart';
import '../models/order_offer_item_model.dart';
import '../models/order_returned_meal_item_model.dart';

/// In-memory stand-in for the real Dio-backed data source — no backend
/// exists yet, same convention as `FakeMealRemoteDataSource`. Shared as one
/// `@lazySingleton` instance across both `view_orders` and `order_details`
/// so they mutate the same in-memory list.
@lazySingleton
class FakeOrderRemoteDataSource {
  FakeOrderRemoteDataSource() : _orders = List.of(_seed());

  final List<OrderModel> _orders;

  static List<OrderModel> _seed() {
    final now = DateTime.now();
    return [
      // Plenty of time left before the CK-25 pending timeout (25% of 60min = 15min).
      OrderModel(
        id: 'order-1',
        cookId: currentCookId,
        customerName: 'فاطمة علي',
        deliveryMethod: OrderDeliveryMethod.pickup,
        status: OrderStatus.pending,
        createdAt: now.subtract(const Duration(minutes: 2)),
        totalExpectedTimeMinutes: 60,
        subtotal: 145,
        discount: 0,
        total: 145,
        mealItems: const [
          OrderMealItemModel(
            mealId: 'meal-1',
            name: 'كبسة دجاج منزلية',
            imageUrl: 'https://picsum.photos/seed/kabsa/200/200',
            quantity: 2,
            priceAtPurchase: 45,
          ),
          OrderMealItemModel(
            mealId: 'meal-3',
            name: 'شوربة عدس',
            imageUrl: 'https://picsum.photos/seed/lentil/200/200',
            quantity: 1,
            priceAtPurchase: 15,
            note: 'بدون ليمون لو سمحت',
          ),
        ],
      ),
      // Already past its pending timeout (createdAt puts it well beyond
      // 25% of totalExpectedTimeMinutes) — exercises CK-25's accept-after-
      // expiry race in `acceptOrder`.
      OrderModel(
        id: 'order-2',
        cookId: currentCookId,
        customerName: 'أحمد عبدالله',
        deliveryMethod: OrderDeliveryMethod.delivery,
        status: OrderStatus.pending,
        createdAt: now.subtract(const Duration(hours: 2)),
        totalExpectedTimeMinutes: 30,
        subtotal: 60,
        discount: 5,
        total: 55,
        mealItems: const [
          OrderMealItemModel(
            mealId: 'meal-4',
            name: 'مسقعة باذنجان',
            imageUrl: 'https://picsum.photos/seed/moussaka/200/200',
            quantity: 2,
            priceAtPurchase: 25,
          ),
        ],
        offerItems: const [
          OrderOfferItemModel(
            offerId: 'offer-1',
            name: 'عرض الغداء العائلي',
            imageUrl: 'https://picsum.photos/seed/family-offer/200/200',
            quantity: 1,
            priceAtPurchase: 10,
          ),
        ],
      ),
      OrderModel(
        id: 'order-3',
        cookId: currentCookId,
        customerName: 'سارة يوسف',
        deliveryMethod: OrderDeliveryMethod.delivery,
        status: OrderStatus.preparing,
        createdAt: now.subtract(const Duration(minutes: 20)),
        totalExpectedTimeMinutes: 45,
        subtotal: 90,
        discount: 0,
        total: 90,
        mealItems: const [
          OrderMealItemModel(
            mealId: 'meal-5',
            name: 'كنافة بالجبن',
            imageUrl: 'https://picsum.photos/seed/kunafa/200/200',
            quantity: 2,
            priceAtPurchase: 20,
            note: 'زيادة قطر',
          ),
          OrderMealItemModel(
            mealId: 'meal-2',
            name: 'فطائر لحم بالفرن',
            imageUrl: 'https://picsum.photos/seed/fatayer/200/200',
            quantity: 2,
            priceAtPurchase: 25,
            selectedOptionLabel: 'وسط',
          ),
        ],
      ),
      OrderModel(
        id: 'order-4',
        cookId: currentCookId,
        customerName: 'خالد إبراهيم',
        deliveryMethod: OrderDeliveryMethod.pickup,
        status: OrderStatus.done,
        createdAt: now.subtract(const Duration(hours: 3)),
        totalExpectedTimeMinutes: 40,
        subtotal: 70,
        discount: 0,
        total: 70,
        mealItems: const [
          OrderMealItemModel(
            mealId: 'meal-1',
            name: 'كبسة دجاج منزلية',
            imageUrl: 'https://picsum.photos/seed/kabsa/200/200',
            quantity: 1,
            priceAtPurchase: 45,
          ),
        ],
      ),
      OrderModel(
        id: 'order-5',
        cookId: currentCookId,
        customerName: 'منى سالم',
        deliveryMethod: OrderDeliveryMethod.delivery,
        status: OrderStatus.rejected,
        createdAt: now.subtract(const Duration(hours: 5)),
        totalExpectedTimeMinutes: 50,
        subtotal: 55,
        discount: 0,
        total: 55,
        rejectionReason: 'لا تتوفر المكونات اللازمة لتحضير هذا الطلب حالياً.',
        mealItems: const [
          OrderMealItemModel(
            mealId: 'meal-3',
            name: 'شوربة عدس',
            imageUrl: 'https://picsum.photos/seed/lentil/200/200',
            quantity: 3,
            priceAtPurchase: 15,
          ),
        ],
      ),
      // Mixes all three item types — exercises CK-17's "offer shown as one
      // line, never exploded" rule alongside a regular meal and a
      // discount-recovery returned meal.
      OrderModel(
        id: 'order-6',
        cookId: currentCookId,
        customerName: 'عمر ناصر',
        deliveryMethod: OrderDeliveryMethod.pickup,
        status: OrderStatus.pending,
        createdAt: now.subtract(const Duration(minutes: 5)),
        totalExpectedTimeMinutes: 60,
        subtotal: 120,
        discount: 10,
        total: 110,
        mealItems: const [
          OrderMealItemModel(
            mealId: 'meal-4',
            name: 'مسقعة باذنجان',
            imageUrl: 'https://picsum.photos/seed/moussaka/200/200',
            quantity: 1,
            priceAtPurchase: 25,
          ),
        ],
        offerItems: const [
          OrderOfferItemModel(
            offerId: 'offer-1',
            name: 'عرض الغداء العائلي',
            imageUrl: 'https://picsum.photos/seed/family-offer/200/200',
            quantity: 1,
            priceAtPurchase: 65,
          ),
        ],
        returnedMealItems: const [
          OrderReturnedMealItemModel(
            mealId: 'meal-5',
            name: 'كنافة بالجبن',
            imageUrl: 'https://picsum.photos/seed/kunafa/200/200',
            quantity: 1,
            priceAtPurchase: 20,
            returnedReason: 'استرجاع خصم عرض سابق',
          ),
        ],
      ),
    ];
  }

  Future<List<OrderModel>> getOrders({
    required String cookId,
    OrderStatus? statusFilter,
  }) async {
    return _orders
        .where((o) => o.cookId == cookId && (statusFilter == null || o.status == statusFilter))
        .toList(growable: false);
  }

  Future<OrderModel?> getOrderById(String id) async {
    for (final order in _orders) {
      if (order.id == id) return order;
    }
    return null;
  }

  /// CK-18 Accept. Only valid from `pending`. Mirrors the backend's
  /// pessimistic-lock re-check (CK-25): if the pending timeout has already
  /// expired, the order is flipped to `cancelled` here (simulating the
  /// scheduled auto-cancel job) and a [ConflictException] is thrown instead
  /// of honoring the accept.
  Future<OrderModel> acceptOrder(String id) async {
    final order = await _requireOrder(id);
    if (order.status != OrderStatus.pending) {
      throw ConflictException('This order is no longer pending.');
    }
    if (order.toEntity().isPendingExpired) {
      final cancelled = order.copyWith(status: OrderStatus.cancelled);
      _replace(cancelled);
      // 410 Gone — distinguishes CK-25's "already expired" race from the
      // generic 409 "wrong current status" case below, so callers can
      // branch on `statusCode` instead of string-matching the message.
      throw const ConflictException(
        'Sorry, the order timeout has expired and the order was cancelled automatically.',
        statusCode: 410,
      );
    }
    final updated = order.copyWith(status: OrderStatus.preparing);
    _replace(updated);
    return updated;
  }

  /// CK-18 Reject. Only valid from `pending`; [reason] is mandatory
  /// free-text, enforced by the caller (repository/Bloc) before this is
  /// ever invoked — this layer just persists it.
  Future<OrderModel> rejectOrder({required String id, required String reason}) async {
    final order = await _requireOrder(id);
    if (order.status != OrderStatus.pending) {
      throw ConflictException('This order is no longer pending.');
    }
    final updated = order.copyWith(status: OrderStatus.rejected, rejectionReason: reason);
    _replace(updated);
    return updated;
  }

  /// CK-19 Complete. Only valid from `preparing`.
  Future<OrderModel> completeOrder(String id) async {
    final order = await _requireOrder(id);
    if (order.status != OrderStatus.preparing) {
      throw ConflictException('This order is not in progress.');
    }
    final updated = order.copyWith(status: OrderStatus.done);
    _replace(updated);
    return updated;
  }

  Future<OrderModel> _requireOrder(String id) async {
    final order = await getOrderById(id);
    if (order == null) throw const NotFoundException('Order not found');
    return order;
  }

  void _replace(OrderModel updated) {
    final index = _orders.indexWhere((o) => o.id == updated.id);
    _orders[index] = updated;
  }
}
