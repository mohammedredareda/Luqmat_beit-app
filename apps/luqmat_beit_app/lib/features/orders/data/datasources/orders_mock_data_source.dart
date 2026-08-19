import 'package:core/core.dart';

import '../../../../shared/mock/sample_catalog.dart';
import 'orders_data_source.dart';

/// Stands in for `orders_remote_data_source.dart` until a backend exists.
/// `_orders` doubles as the backing store for both `getOrderById` (the
/// just-placed order shown on Order Confirmation / Invoice) and
/// `getInProgressOrders` (My Orders list) — same shape a real API would
/// return from `/orders/:id` and `/orders?status=in_progress`.
class OrdersMockDataSource implements OrdersDataSource {
  @override
  Future<OrderEntity> getOrderById(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _orders.firstWhere(
      (order) => order.id == orderId,
      orElse: () => throw const NotFoundException('لم يتم العثور على الطلب.'),
    );
  }

  @override
  Future<List<OrderEntity>> getInProgressOrders() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _orders.where((order) => order.status.isActive).toList();
  }

  @override
  Future<({double price, int expectedTimeMinutes})> getDeliveryPrice({
    required String cookId,
    required double latitude,
    required double longitude,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return (price: 10.0, expectedTimeMinutes: 45);
  }

  @override
  Future<String> confirmOrder({
    required String cookId,
    required String deliveryAddress,
    required double deliveryFee,
    List<CartMealItemEntity> mealItems = const [],
    List<CartOfferItemEntity> offerItems = const [],
    List<CartReturnedMealItemEntity> returnedMealItems = const [],
    double? latitude,
    double? longitude,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final id = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
    _orders.add(OrderEntity(
      id: id,
      cookId: cookId,
      cookName: mealItems.isNotEmpty
          ? SampleCatalog.mealById(mealItems.first.mealId).cookName
          : '',
      customerId: 'customer-1',
      createdAt: DateTime.now(),
      status: OrderStatus.pending,
      deliveryAddress: deliveryAddress,
      deliveryFee: deliveryFee,
      totalExpectedTimeMinutes: 45,
      mealItems: mealItems
          .map((item) => OrderMealItemEntity(
                id: item.id,
                mealId: item.mealId,
                mealName: item.mealName,
                mealImageUrl: item.mealImageUrl,
                sellingOptionLabel: item.sellingOptionLabel,
                priceAtPurchase: item.unitPrice,
                quantity: item.quantity,
                note: item.note,
              ))
          .toList(),
      offerItems: offerItems
          .map((item) => OrderOfferItemEntity(
                id: item.id,
                offerId: item.offerId,
                offerName: item.offerName,
                priceAtPurchase: item.unitPrice,
                quantity: item.quantity,
              ))
          .toList(),
      returnedMealItems: returnedMealItems
          .map((item) => OrderReturnedMealItemEntity(
                id: item.id,
                returnedMealId: item.returnedMealId,
                mealName: item.mealName,
                mealImageUrl: item.mealImageUrl,
                priceAtPurchase: item.salvagePrice,
                quantity: item.quantity,
              ))
          .toList(),
    ));
    return id;
  }

  @override
  Future<String> confirmReturnedMealsOrder({
    required List<CartReturnedMealItemEntity> returnedMealItems,
    double? latitude,
    double? longitude,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final id = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
    _orders.add(OrderEntity(
      id: id,
      cookId: '',
      cookName: '',
      customerId: 'customer-1',
      createdAt: DateTime.now(),
      status: OrderStatus.pending,
      deliveryAddress: '',
      deliveryFee: 0,
      totalExpectedTimeMinutes: 45,
      returnedMealItems: returnedMealItems
          .map((item) => OrderReturnedMealItemEntity(
                id: item.id,
                returnedMealId: item.returnedMealId,
                mealName: item.mealName,
                mealImageUrl: item.mealImageUrl,
                priceAtPurchase: item.salvagePrice,
                quantity: item.quantity,
              ))
          .toList(),
    ));
    return id;
  }

  static final meal1 = SampleCatalog.mealById('meal-1');
  static final meal3 = SampleCatalog.mealById('meal-3');

  static final _orders = <OrderEntity>[
    // The just-placed order shown on Order Confirmation / Invoice (U06/U08).
    OrderEntity(
      id: 'ORD-2026-014',
      cookId: 'cook-2',
      cookName: 'مطبخ سلمى الفلسطيني',
      customerId: 'customer-1',
      createdAt: DateTime(2026, 7, 10, 13, 30),
      status: OrderStatus.delivered,
      deliveryAddress: 'شارع الزيتون، رام الله',
      deliveryFee: 10,
      discountAmount: 10,
      totalExpectedTimeMinutes: 45,
      mealItems: const [
        OrderMealItemEntity(
          id: 'item-014-1',
          mealId: 'meal-kabsa',
          mealName: 'كبسة دجاج',
          mealImageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCkD8-eLNtXO1AAv80KI49zuHLEKWmpKgkpzppLfWgPwOGLpPeMS7FHS2ZBBdzg2ZxHE3ZgBFNgXc80yL94SoUTXYaFNskpyqxczpwjxPiu7kvSTxCi6PEqXBBgw85K4Qb7eIAKX6vn4bpfapH1wOg3vNkawROvvq44rs9OdK7pyXwEYlplWIeOk-rWyH-5mbcx6kRZysERvLSqtEYGqf2coND2JokIYPmEngY_jwEfbZ_YMd4hJ58A',
          sellingOptionLabel: 'صحن',
          priceAtPurchase: 40,
          quantity: 2,
        ),
        OrderMealItemEntity(
          id: 'item-014-2',
          mealId: 'meal-fattoush',
          mealName: 'فتوش',
          mealImageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuA_T50-Ybv9jlSr0mmILjDvoewDTopN2b_6l9m5xFyxe_4qAtCl93ek4DWbFKBc8WDyS2fN7Cc6pyY5von8_zOwH28eSNhZ7Xt7eXyeRQJM04a6YY8gDWcsZwX8dESdnSXDhxBY06OmxFL0GHRie9mdlRMBsX1LTKIMCjowgenbZzaMLRwE-KQglr9iGJGYdxXhpcucmMfEmLbcvXhq-NaXbzu_rKuij4Dm-uuELnR_60CwvTBgpcKw',
          sellingOptionLabel: 'صحن',
          priceAtPurchase: 15,
          quantity: 1,
        ),
      ],
    ),
    // In-progress list (U09) — preparing.
    OrderEntity(
      id: 'ORD-2026-020',
      cookId: 'cook-1',
      cookName: 'أم أحمد',
      cookAvatarUrl: meal1.cookAvatarUrl,
      customerId: 'customer-1',
      createdAt: DateTime(2026, 7, 2),
      status: OrderStatus.preparing,
      deliveryAddress: 'شارع الزيتون، رام الله',
      deliveryFee: 8,
      totalExpectedTimeMinutes: 40,
      mealItems: [
        OrderMealItemEntity(
          id: 'item-020-1',
          mealId: meal1.id,
          mealName: 'مقلوبة باذنجان لحم',
          mealImageUrl: meal1.imageUrl,
          sellingOptionLabel: 'صحن',
          priceAtPurchase: meal1.startingPrice,
          quantity: 1,
        ),
      ],
    ),
    // In-progress list (U09) — pending.
    OrderEntity(
      id: 'ORD-2026-021',
      cookId: 'cook-4',
      cookName: 'الشيف محمود',
      customerId: 'customer-1',
      createdAt: DateTime(2026, 7, 5),
      status: OrderStatus.pending,
      deliveryAddress: 'شارع الإرسال، غزة',
      deliveryFee: 8,
      totalExpectedTimeMinutes: 50,
      pendingExpiresAt: DateTime(2026, 7, 5, 0, 12, 30),
      mealItems: const [
        OrderMealItemEntity(
          id: 'item-021-1',
          mealId: 'meal-warak-enab',
          mealName: 'ورق عنب بالزيت',
          mealImageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuByPJ06q2ei6EZ2J8CwZ5ZrbeJGPTGLPIQ4jyT3ebcGWPgCWJSgg_VzylQtwlkf9LRqts_SSkwA8rz527XCRJJQ38F2dUxjgI_Cbbb3qzu1sD02p6J2C9pocvFOWFyFo54UL14lynbPsYUFC4nWnsSTIO4K2rf1QvI8Ydb8IHy3QmuzaCgioLAWLZF_2rL9-RFwqGzl9i7WoLCfUlaEPF8yvI0KXBmWEHYZh0MEJ3NZOrNUp3h4di_X',
          sellingOptionLabel: 'صحن',
          priceAtPurchase: 30,
          quantity: 1,
        ),
      ],
    ),
    // In-progress list (U09) — rejected.
    OrderEntity(
      id: 'ORD-2026-022',
      cookId: 'cook-5',
      cookName: 'خالة فاطمة',
      customerId: 'customer-1',
      createdAt: DateTime(2026, 6, 28),
      status: OrderStatus.rejected,
      rejectionReason: 'لا يمكن تحضير الطلب حالياً بسبب ضغط الطلبات.',
      deliveryAddress: 'شارع الجلاء، الخليل',
      deliveryFee: 8,
      totalExpectedTimeMinutes: 30,
      mealItems: [
        OrderMealItemEntity(
          id: 'item-022-1',
          mealId: meal3.id,
          mealName: 'شوربة عدس',
          mealImageUrl: meal3.imageUrl,
          sellingOptionLabel: 'صحن',
          priceAtPurchase: meal3.startingPrice,
          quantity: 1,
        ),
      ],
    ),
  ];
}
