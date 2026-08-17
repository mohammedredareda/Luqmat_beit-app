import '../../../../../support/bloc_test_helper.dart';
import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'package:luqmat_beit_app/features/meal_management/view_menu/domain/usecases/get_my_meals.dart';
import 'package:luqmat_beit_app/features/meal_management/view_menu/presentation/bloc/view_menu_cubit.dart';
import 'package:luqmat_beit_app/features/meal_management/view_menu/presentation/bloc/view_menu_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetMyMeals extends Mock implements GetMyMeals {}

void main() {
  late _MockGetMyMeals getMyMeals;

  setUp(() {
    getMyMeals = _MockGetMyMeals();
  });

  final activeMeal = const MealEntity(
    id: 'meal-1',
    cookId: currentCookId,
    cookName: 'مطبخ أم أحمد',
    name: 'كبسة دجاج منزلية',
    description: 'أرز بسمتي مع دجاج متبل',
    sellingOptions: [],
    singlePrice: 45,
    imageUrl: 'https://example.com/kabsa.png',
  );

  final secondMeal = const MealEntity(
    id: 'meal-2',
    cookId: currentCookId,
    cookName: 'مطبخ أم أحمد',
    name: 'فطائر لحم بالفرن',
    description: 'عجينة منزلية محشوة بلحم مفروم',
    sellingOptions: [],
    singlePrice: 25,
    imageUrl: 'https://example.com/fatayer.png',
  );

  // CK-06 AC: "Menu with existing meals" — meals are listed as loaded.
  blocTest<ViewMenuCubit, ViewMenuState>(
    'emits [loading, loaded] with the meals the repository returns',
    setUp: () {
      when(() => getMyMeals(currentCookId)).thenAnswer(
        (_) async => Result.success((
          page: PaginatedResult(items: [activeMeal], hasMore: false),
          isSellingPaused: false,
        )),
      );
    },
    build: () => ViewMenuCubit(getMyMeals),
    act: (cubit) => cubit.loadMenu(),
    expect: () => [
      const ViewMenuState.loading(),
      ViewMenuState.loaded(
        meals: [activeMeal],
        isSellingPaused: false,
        hasMore: false,
        isLoadingMore: false,
      ),
    ],
  );

  // CK-06 AC: "Empty menu" — no meals yet, empty list is emitted as loaded.
  blocTest<ViewMenuCubit, ViewMenuState>(
    'emits [loading, loaded(empty)] when the cook has no meals',
    setUp: () {
      when(() => getMyMeals(currentCookId)).thenAnswer(
        (_) async => Result.success((
          page: const PaginatedResult<MealEntity>(items: [], hasMore: false),
          isSellingPaused: false,
        )),
      );
    },
    build: () => ViewMenuCubit(getMyMeals),
    act: (cubit) => cubit.loadMenu(),
    expect: () => [
      const ViewMenuState.loading(),
      const ViewMenuState.loaded(
        meals: [],
        isSellingPaused: false,
        hasMore: false,
        isLoadingMore: false,
      ),
    ],
  );

  // CK-06 AC: "Menu still loading" — loading is always emitted first,
  // and a repository failure surfaces as a typed error state, not a crash.
  blocTest<ViewMenuCubit, ViewMenuState>(
    'emits [loading, error] when the repository call fails',
    setUp: () {
      when(() => getMyMeals(currentCookId)).thenAnswer(
        (_) async => const Result.failure(NetworkException()),
      );
    },
    build: () => ViewMenuCubit(getMyMeals),
    act: (cubit) => cubit.loadMenu(),
    expect: () => [
      const ViewMenuState.loading(),
      const ViewMenuState.error(NetworkException()),
    ],
  );

  // Second page appends to the first without dropping or duplicating items.
  blocTest<ViewMenuCubit, ViewMenuState>(
    'loadMore appends the next page and keeps hasMore in sync',
    setUp: () {
      when(() => getMyMeals(currentCookId)).thenAnswer(
        (_) async => Result.success((
          page: PaginatedResult(items: [activeMeal], hasMore: true, nextCursor: 'meal-1'),
          isSellingPaused: false,
        )),
      );
      when(() => getMyMeals(currentCookId, cursor: 'meal-1')).thenAnswer(
        (_) async => Result.success((
          page: PaginatedResult(items: [secondMeal], hasMore: false),
          isSellingPaused: false,
        )),
      );
    },
    build: () => ViewMenuCubit(getMyMeals),
    act: (cubit) async {
      await cubit.loadMenu();
      await cubit.loadMore();
    },
    expect: () => [
      const ViewMenuState.loading(),
      ViewMenuState.loaded(
        meals: [activeMeal],
        isSellingPaused: false,
        hasMore: true,
        isLoadingMore: false,
      ),
      ViewMenuState.loaded(
        meals: [activeMeal],
        isSellingPaused: false,
        hasMore: true,
        isLoadingMore: true,
      ),
      ViewMenuState.loaded(
        meals: [activeMeal, secondMeal],
        isSellingPaused: false,
        hasMore: false,
        isLoadingMore: false,
      ),
    ],
  );

  // Optimistic updates: the Edit/Delete Meal screens already hand back the
  // updated MealEntity (or id), so the dashboard reflects it immediately —
  // neither should trigger another repository call. Creation has no
  // equivalent (see ViewMenuCubit's doc comment on replaceMeal): the
  // backend's create response has no meal data to add optimistically, so
  // that path still goes through a real loadMenu() refetch.
  final updatedActiveMeal = const MealEntity(
    id: 'meal-1',
    cookId: currentCookId,
    cookName: 'مطبخ أم أحمد',
    name: 'كبسة دجاج محدثة',
    description: 'أرز بسمتي مع دجاج متبل',
    sellingOptions: [],
    singlePrice: 50,
    imageUrl: 'https://example.com/kabsa.png',
  );

  blocTest<ViewMenuCubit, ViewMenuState>(
    'replaceMeal swaps in the updated meal by id without refetching',
    setUp: () {
      when(() => getMyMeals(currentCookId)).thenAnswer(
        (_) async => Result.success((
          page: PaginatedResult(items: [activeMeal, secondMeal], hasMore: false),
          isSellingPaused: false,
        )),
      );
    },
    build: () => ViewMenuCubit(getMyMeals),
    act: (cubit) async {
      await cubit.loadMenu();
      cubit.replaceMeal(updatedActiveMeal);
    },
    expect: () => [
      const ViewMenuState.loading(),
      ViewMenuState.loaded(
        meals: [activeMeal, secondMeal],
        isSellingPaused: false,
        hasMore: false,
        isLoadingMore: false,
      ),
      ViewMenuState.loaded(
        meals: [updatedActiveMeal, secondMeal],
        isSellingPaused: false,
        hasMore: false,
        isLoadingMore: false,
      ),
    ],
    verify: (_) => verify(() => getMyMeals(currentCookId)).called(1),
  );

  blocTest<ViewMenuCubit, ViewMenuState>(
    'removeMeal drops the meal by id without refetching',
    setUp: () {
      when(() => getMyMeals(currentCookId)).thenAnswer(
        (_) async => Result.success((
          page: PaginatedResult(items: [activeMeal, secondMeal], hasMore: false),
          isSellingPaused: false,
        )),
      );
    },
    build: () => ViewMenuCubit(getMyMeals),
    act: (cubit) async {
      await cubit.loadMenu();
      cubit.removeMeal(activeMeal.id);
    },
    expect: () => [
      const ViewMenuState.loading(),
      ViewMenuState.loaded(
        meals: [activeMeal, secondMeal],
        isSellingPaused: false,
        hasMore: false,
        isLoadingMore: false,
      ),
      ViewMenuState.loaded(
        meals: [secondMeal],
        isSellingPaused: false,
        hasMore: false,
        isLoadingMore: false,
      ),
    ],
    verify: (_) => verify(() => getMyMeals(currentCookId)).called(1),
  );

  blocTest<ViewMenuCubit, ViewMenuState>(
    'replaceMeal/removeMeal before any load are no-ops',
    build: () => ViewMenuCubit(getMyMeals),
    act: (cubit) {
      cubit.replaceMeal(activeMeal);
      cubit.removeMeal(activeMeal.id);
    },
    expect: () => const <ViewMenuState>[],
  );
}
