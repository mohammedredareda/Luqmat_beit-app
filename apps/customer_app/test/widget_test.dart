import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:customer_app/di/injection.dart';
import 'package:customer_app/features/home/domain/entities/home_feed_entity.dart';
import 'package:customer_app/features/home/domain/repositories/home_repository.dart';
import 'package:customer_app/features/home/presentation/pages/home_page.dart';

class _FakeHomeRepository implements HomeRepository {
  @override
  Future<Result<HomeFeedEntity>> getHomeFeed() async {
    return const Result.success(
      HomeFeedEntity(
        categories: [],
        bestSellers: [],
        chefs: [],
        offers: [],
        bigDiscounts: [],
        discountsByMealId: {},
      ),
    );
  }
}

void main() {
  setUp(() async {
    await getIt.reset();
    getIt.registerLazySingleton<HomeRepository>(() => _FakeHomeRepository());
  });

  testWidgets('HomePage loads an empty feed without error', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const HomePage(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
