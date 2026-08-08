import '../../../../../support/bloc_test_helper.dart';
import 'package:luqmat_beit_app/features/order_management/view_orders/domain/usecases/get_orders.dart';
import 'package:luqmat_beit_app/features/order_management/view_orders/presentation/bloc/view_orders_cubit.dart';
import 'package:luqmat_beit_app/features/order_management/view_orders/presentation/bloc/view_orders_state.dart';
import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetOrders extends Mock implements GetOrders {}

void main() {
  late _MockGetOrders getOrders;

  setUp(() {
    getOrders = _MockGetOrders();
  });

  OrderEntity buildOrder(String id) => OrderEntity(
        id: id,
        cookId: currentCookId,
        cookName: 'مطبخي',
        customerId: 'customer-$id',
        customerName: 'عميل $id',
        status: OrderStatus.pending,
        createdAt: DateTime.now(),
        totalExpectedTimeMinutes: 30,
        deliveryAddress: 'عنوان تجريبي',
      );

  final firstOrder = buildOrder('order-a');
  final secondOrder = buildOrder('order-b');

  blocTest<ViewOrdersCubit, ViewOrdersState>(
    'emits [loading, loaded] with the first page the repository returns',
    setUp: () {
      when(() => getOrders(cookId: currentCookId, statusFilter: OrderStatus.pending)).thenAnswer(
        (_) async => Result.success(
          PaginatedResult(items: [firstOrder], hasMore: true, nextCursor: 'order-a'),
        ),
      );
    },
    build: () => ViewOrdersCubit(getOrders),
    act: (cubit) => cubit.loadOrders(OrderStatus.pending),
    expect: () => [
      const ViewOrdersState.loading(),
      ViewOrdersState.loaded(orders: [firstOrder], hasMore: true, isLoadingMore: false),
    ],
  );

  blocTest<ViewOrdersCubit, ViewOrdersState>(
    'emits [loading, error] when the repository call fails',
    setUp: () {
      when(() => getOrders(cookId: currentCookId, statusFilter: OrderStatus.pending)).thenAnswer(
        (_) async => const Result.failure(NetworkException()),
      );
    },
    build: () => ViewOrdersCubit(getOrders),
    act: (cubit) => cubit.loadOrders(OrderStatus.pending),
    expect: () => [
      const ViewOrdersState.loading(),
      const ViewOrdersState.error(NetworkException()),
    ],
  );

  blocTest<ViewOrdersCubit, ViewOrdersState>(
    'loadMore appends the next page using the cursor from the first page',
    setUp: () {
      when(() => getOrders(cookId: currentCookId, statusFilter: OrderStatus.pending)).thenAnswer(
        (_) async => Result.success(
          PaginatedResult(items: [firstOrder], hasMore: true, nextCursor: 'order-a'),
        ),
      );
      when(
        () => getOrders(cookId: currentCookId, statusFilter: OrderStatus.pending, cursor: 'order-a'),
      ).thenAnswer(
        (_) async => Result.success(PaginatedResult(items: [secondOrder], hasMore: false)),
      );
    },
    build: () => ViewOrdersCubit(getOrders),
    act: (cubit) async {
      await cubit.loadOrders(OrderStatus.pending);
      await cubit.loadMore();
    },
    expect: () => [
      const ViewOrdersState.loading(),
      ViewOrdersState.loaded(orders: [firstOrder], hasMore: true, isLoadingMore: false),
      ViewOrdersState.loaded(orders: [firstOrder], hasMore: true, isLoadingMore: true),
      ViewOrdersState.loaded(
        orders: [firstOrder, secondOrder],
        hasMore: false,
        isLoadingMore: false,
      ),
    ],
  );

  blocTest<ViewOrdersCubit, ViewOrdersState>(
    'switching the status filter resets to page one instead of appending',
    setUp: () {
      when(() => getOrders(cookId: currentCookId, statusFilter: OrderStatus.pending)).thenAnswer(
        (_) async => Result.success(PaginatedResult(items: [firstOrder], hasMore: false)),
      );
      when(() => getOrders(cookId: currentCookId, statusFilter: OrderStatus.done)).thenAnswer(
        (_) async => Result.success(PaginatedResult(items: [secondOrder], hasMore: false)),
      );
    },
    build: () => ViewOrdersCubit(getOrders),
    act: (cubit) async {
      await cubit.loadOrders(OrderStatus.pending);
      await cubit.loadOrders(OrderStatus.done);
    },
    expect: () => [
      const ViewOrdersState.loading(),
      ViewOrdersState.loaded(orders: [firstOrder], hasMore: false, isLoadingMore: false),
      const ViewOrdersState.loading(),
      ViewOrdersState.loaded(orders: [secondOrder], hasMore: false, isLoadingMore: false),
    ],
  );
}
