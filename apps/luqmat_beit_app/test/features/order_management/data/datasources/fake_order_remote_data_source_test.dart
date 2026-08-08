import 'package:luqmat_beit_app/features/order_management/data/datasources/fake_order_remote_data_source.dart';
import 'package:luqmat_beit_app/features/order_management/data/models/order_model.dart';
import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeOrderRemoteDataSource dataSource;

  setUp(() {
    dataSource = FakeOrderRemoteDataSource();
  });

  test('getOrders returns one cursor page and honors pageSize/hasMore', () async {
    final firstPage = await dataSource.getOrders(cookId: currentCookId, pageSize: 10);
    expect(firstPage.items, hasLength(10));
    expect(firstPage.hasMore, isTrue);
    expect(firstPage.nextCursor, isNotNull);

    final secondPage = await dataSource.getOrders(
      cookId: currentCookId,
      cursor: firstPage.nextCursor,
      pageSize: 10,
    );
    expect(secondPage.items, hasLength(10));
    final firstIds = firstPage.items.map((o) => o.id).toSet();
    expect(secondPage.items.any((o) => firstIds.contains(o.id)), isFalse);
  });

  test('paging through every order reaches hasMore: false with no duplicates', () async {
    String? cursor;
    final seenIds = <String>{};
    PaginatedResult<OrderModel> page;
    do {
      page = await dataSource.getOrders(cookId: currentCookId, cursor: cursor, pageSize: 15);
      for (final order in page.items) {
        expect(seenIds.add(order.id), isTrue, reason: 'order ${order.id} seen twice');
      }
      cursor = page.nextCursor;
    } while (page.hasMore);

    expect(seenIds, isNotEmpty);
  });

  test('statusFilter narrows the paginated result to just that status', () async {
    final page = await dataSource.getOrders(
      cookId: currentCookId,
      statusFilter: OrderStatus.rejected,
      pageSize: 100,
    );

    expect(page.items, isNotEmpty);
    expect(page.items.every((o) => o.status == OrderStatus.rejected), isTrue);
  });
}
