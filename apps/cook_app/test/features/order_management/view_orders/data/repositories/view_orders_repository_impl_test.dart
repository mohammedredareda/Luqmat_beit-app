import 'package:cook_app/features/order_management/data/datasources/fake_order_remote_data_source.dart';
import 'package:cook_app/features/order_management/view_orders/data/repositories/view_orders_repository_impl.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeOrderRemoteDataSource dataSource;
  late ViewOrdersRepositoryImpl repository;

  setUp(() {
    dataSource = FakeOrderRemoteDataSource();
    repository = ViewOrdersRepositoryImpl(dataSource);
  });

  test('getOrders returns Result.success with a paginated page of orders', () async {
    final result = await repository.getOrders(cookId: currentCookId, pageSize: 10);

    expect(result, isA<Success<PaginatedResult<OrderEntity>>>());
    final page = (result as Success<PaginatedResult<OrderEntity>>).data;
    expect(page.items, hasLength(10));
    expect(page.hasMore, isTrue);
  });

  test('cursor from the first page fetches a disjoint second page', () async {
    final first = await repository.getOrders(cookId: currentCookId, pageSize: 10);
    final firstPage = (first as Success<PaginatedResult<OrderEntity>>).data;

    final second = await repository.getOrders(
      cookId: currentCookId,
      cursor: firstPage.nextCursor,
      pageSize: 10,
    );
    final secondPage = (second as Success<PaginatedResult<OrderEntity>>).data;

    final firstIds = firstPage.items.map((o) => o.id).toSet();
    expect(secondPage.items.any((o) => firstIds.contains(o.id)), isFalse);
  });

  test('statusFilter is forwarded through to the paginated result', () async {
    final result = await repository.getOrders(
      cookId: currentCookId,
      statusFilter: OrderStatus.done,
      pageSize: 100,
    );
    final page = (result as Success<PaginatedResult<OrderEntity>>).data;

    expect(page.items, isNotEmpty);
    expect(page.items.every((o) => o.status == OrderStatus.done), isTrue);
  });
}
