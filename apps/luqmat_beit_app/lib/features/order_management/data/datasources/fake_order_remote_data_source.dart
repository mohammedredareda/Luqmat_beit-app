import 'package:core/core.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'package:luqmat_beit_app/shared/in_memory_pagination.dart';
import '../models/order_meal_item_model.dart';
import '../models/order_model.dart';
import '../models/order_offer_item_model.dart';
import '../models/order_returned_meal_item_model.dart';

/// In-memory stand-in for the real Dio-backed data source — no backend
/// exists yet, same convention as `FakeMealRemoteDataSource`. Shared as one
/// `@lazySingleton` instance across both `view_orders` and `order_details`
/// so they mutate the same in-memory list.
class FakeOrderRemoteDataSource {
  FakeOrderRemoteDataSource() : _orders = List.of(_seed());

  final List<OrderModel> _orders;

  static const _cookName = 'مطبخي';
  static const _deliveryAddress = 'شارع الملك فيصل، حي الروضة، بناء 12';

  static List<OrderModel> _seed() {
    final now = DateTime.now();
    return [
      // Plenty of time left before the CK-25 pending timeout (25% of 60min = 15min).
      OrderModel(
        id: 'order-1',
        cookId: currentCookId,
        cookName: _cookName,
        customerId: 'customer-1',
        customerName: 'فاطمة علي',
        status: OrderStatus.pending,
        createdAt: now.subtract(const Duration(minutes: 2)),
        totalExpectedTimeMinutes: 60,
        deliveryAddress: _deliveryAddress,
        mealItems: const [
          OrderMealItemModel(
            id: 'order-1-item-1',
            mealId: 'meal-1',
            mealName: 'كبسة دجاج منزلية',
            mealImageUrl: 'https://picsum.photos/seed/kabsa/200/200',
            quantity: 2,
            priceAtPurchase: 45,
          ),
          OrderMealItemModel(
            id: 'order-1-item-2',
            mealId: 'meal-3',
            mealName: 'شوربة عدس',
            mealImageUrl: 'https://picsum.photos/seed/lentil/200/200',
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
        cookName: _cookName,
        customerId: 'customer-2',
        customerName: 'أحمد عبدالله',
        status: OrderStatus.pending,
        createdAt: now.subtract(const Duration(hours: 2)),
        totalExpectedTimeMinutes: 30,
        deliveryAddress: _deliveryAddress,
        discountAmount: 5,
        mealItems: const [
          OrderMealItemModel(
            id: 'order-2-item-1',
            mealId: 'meal-4',
            mealName: 'مسقعة باذنجان',
            mealImageUrl: 'https://picsum.photos/seed/moussaka/200/200',
            quantity: 2,
            priceAtPurchase: 25,
          ),
        ],
        offerItems: const [
          OrderOfferItemModel(
            id: 'order-2-item-2',
            offerId: 'offer-1',
            offerName: 'عرض الغداء العائلي',
            quantity: 1,
            priceAtPurchase: 10,
          ),
        ],
      ),
      OrderModel(
        id: 'order-3',
        cookId: currentCookId,
        cookName: _cookName,
        customerId: 'customer-3',
        customerName: 'سارة يوسف',
        status: OrderStatus.preparing,
        createdAt: now.subtract(const Duration(minutes: 20)),
        totalExpectedTimeMinutes: 45,
        deliveryAddress: _deliveryAddress,
        mealItems: const [
          OrderMealItemModel(
            id: 'order-3-item-1',
            mealId: 'meal-5',
            mealName: 'كنافة بالجبن',
            mealImageUrl: 'https://picsum.photos/seed/kunafa/200/200',
            quantity: 2,
            priceAtPurchase: 20,
            note: 'زيادة قطر',
          ),
          OrderMealItemModel(
            id: 'order-3-item-2',
            mealId: 'meal-2',
            mealName: 'فطائر لحم بالفرن',
            mealImageUrl: 'https://picsum.photos/seed/fatayer/200/200',
            quantity: 2,
            priceAtPurchase: 25,
            sellingOptionLabel: 'وسط',
          ),
        ],
      ),
      OrderModel(
        id: 'order-4',
        cookId: currentCookId,
        cookName: _cookName,
        customerId: 'customer-4',
        customerName: 'خالد إبراهيم',
        status: OrderStatus.done,
        createdAt: now.subtract(const Duration(hours: 3)),
        totalExpectedTimeMinutes: 40,
        deliveryAddress: _deliveryAddress,
        mealItems: const [
          OrderMealItemModel(
            id: 'order-4-item-1',
            mealId: 'meal-1',
            mealName: 'كبسة دجاج منزلية',
            mealImageUrl: 'https://picsum.photos/seed/kabsa/200/200',
            quantity: 1,
            priceAtPurchase: 45,
          ),
        ],
      ),
      OrderModel(
        id: 'order-5',
        cookId: currentCookId,
        cookName: _cookName,
        customerId: 'customer-5',
        customerName: 'منى سالم',
        status: OrderStatus.rejected,
        createdAt: now.subtract(const Duration(hours: 5)),
        totalExpectedTimeMinutes: 50,
        deliveryAddress: _deliveryAddress,
        rejectionReason: 'لا تتوفر المكونات اللازمة لتحضير هذا الطلب حالياً.',
        mealItems: const [
          OrderMealItemModel(
            id: 'order-5-item-1',
            mealId: 'meal-3',
            mealName: 'شوربة عدس',
            mealImageUrl: 'https://picsum.photos/seed/lentil/200/200',
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
        cookName: _cookName,
        customerId: 'customer-6',
        customerName: 'عمر ناصر',
        status: OrderStatus.pending,
        createdAt: now.subtract(const Duration(minutes: 5)),
        totalExpectedTimeMinutes: 60,
        deliveryAddress: _deliveryAddress,
        discountAmount: 10,
        mealItems: const [
          OrderMealItemModel(
            id: 'order-6-item-1',
            mealId: 'meal-4',
            mealName: 'مسقعة باذنجان',
            mealImageUrl: 'https://picsum.photos/seed/moussaka/200/200',
            quantity: 1,
            priceAtPurchase: 25,
          ),
        ],
        offerItems: const [
          OrderOfferItemModel(
            id: 'order-6-item-2',
            offerId: 'offer-1',
            offerName: 'عرض الغداء العائلي',
            quantity: 1,
            priceAtPurchase: 65,
          ),
        ],
        returnedMealItems: const [
          OrderReturnedMealItemModel(
            id: 'order-6-item-3',
            returnedMealId: 'returned-meal-5',
            mealName: 'كنافة بالجبن',
            mealImageUrl: 'https://picsum.photos/seed/kunafa/200/200',
            quantity: 1,
            priceAtPurchase: 20,
          ),
        ],
      ),
      ..._generateBulkOrders(),
    ];
  }

  /// Bulk-generated orders (10 per status, `order-7` onward) so the list is
  /// large enough to actually exercise cursor pagination end-to-end —
  /// the hand-crafted seed above only covers specific business scenarios
  /// (CK-25's expiry race, CK-17's mixed line-item types, ...).
  static List<OrderModel> _generateBulkOrders() {
    final now = DateTime.now();
    const customerNames = [
      'ليلى حسن', 'يوسف كمال', 'هدى عبدالرحمن', 'ماجد سعيد', 'رنا فؤاد',
      'طارق منير', 'سلمى وليد', 'باسم عادل', 'نور الدين', 'إيمان رضا',
    ];
    const meals = [
      (id: 'meal-1', name: 'كبسة دجاج منزلية', image: 'kabsa', price: 45.0),
      (id: 'meal-2', name: 'فطائر لحم بالفرن', image: 'fatayer', price: 25.0),
      (id: 'meal-3', name: 'شوربة عدس', image: 'lentil', price: 15.0),
      (id: 'meal-4', name: 'مسقعة باذنجان', image: 'moussaka', price: 25.0),
      (id: 'meal-5', name: 'كنافة بالجبن', image: 'kunafa', price: 20.0),
    ];

    final bulk = <OrderModel>[];
    // `delivering`/`delivered`/`returned` are set by the (unimplemented)
    // Delivery Support module downstream of `done`, not seeded directly
    // here; `cancelled` only happens via the CK-25 auto-cancel race.
    const seedableStatuses = [
      OrderStatus.pending,
      OrderStatus.preparing,
      OrderStatus.done,
      OrderStatus.rejected,
    ];
    var counter = 7;
    for (final status in seedableStatuses) {
      for (var i = 0; i < 10; i++) {
        final meal = meals[(counter + i) % meals.length];
        final quantity = 1 + (i % 3);
        // Pending orders stay recent so they don't all read as already
        // past CK-25's pending timeout; other statuses read as history.
        final createdAt = status == OrderStatus.pending
            ? now.subtract(Duration(minutes: 2 + i * 3))
            : now.subtract(Duration(hours: 4 + counter, minutes: i * 7));

        bulk.add(
          OrderModel(
            id: 'order-$counter',
            cookId: currentCookId,
            cookName: _cookName,
            customerId: 'customer-$counter',
            customerName: customerNames[(counter + i) % customerNames.length],
            status: status,
            createdAt: createdAt,
            totalExpectedTimeMinutes: 40,
            deliveryAddress: _deliveryAddress,
            rejectionReason: status == OrderStatus.rejected
                ? 'لا تتوفر المكونات اللازمة لتحضير هذا الطلب حالياً.'
                : null,
            mealItems: [
              OrderMealItemModel(
                id: 'order-$counter-item-1',
                mealId: meal.id,
                mealName: meal.name,
                mealImageUrl: 'https://picsum.photos/seed/${meal.image}/200/200',
                quantity: quantity,
                priceAtPurchase: meal.price,
              ),
            ],
          ),
        );
        counter++;
      }
    }
    return bulk;
  }

  Future<PaginatedResult<OrderModel>> getOrders({
    required String cookId,
    OrderStatus? statusFilter,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) async {
    final filtered = _orders
        .where((o) => o.cookId == cookId && (statusFilter == null || o.status == statusFilter))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return paginateInMemory(
      all: filtered,
      idOf: (o) => o.id,
      cursor: cursor,
      pageSize: pageSize,
    );
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
