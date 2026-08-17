import '../../../../../support/bloc_test_helper.dart';
import 'package:luqmat_beit_app/features/shorts_management/shared/domain/entities/short_management_entity.dart';
import 'package:luqmat_beit_app/features/shorts_management/view_shorts/domain/usecases/get_my_shorts.dart';
import 'package:luqmat_beit_app/features/shorts_management/view_shorts/presentation/bloc/view_shorts_cubit.dart';
import 'package:luqmat_beit_app/features/shorts_management/view_shorts/presentation/bloc/view_shorts_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetMyShorts extends Mock implements GetMyShorts {}

void main() {
  late _MockGetMyShorts getMyShorts;

  setUp(() {
    getMyShorts = _MockGetMyShorts();
  });

  final now = DateTime.now();

  final short = ShortManagementEntity(
    id: 'short-1',
    cookId: 'cook-1',
    description: 'وصف',
    viewCount: 420,
    createdAt: now,
  );

  blocTest<ViewShortsCubit, ViewShortsState>(
    'emits [loading, loaded] with the shorts the repository returns',
    setUp: () {
      when(() => getMyShorts(any())).thenAnswer(
        (_) async => Result.success(PaginatedResult(items: [short], hasMore: false)),
      );
    },
    build: () => ViewShortsCubit(getMyShorts),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ViewShortsState.loading(),
      ViewShortsState.loaded(items: [short], hasMore: false, isLoadingMore: false),
    ],
  );

  blocTest<ViewShortsCubit, ViewShortsState>(
    'emits [loading, loaded(empty)] when the cook has no shorts',
    setUp: () {
      when(() => getMyShorts(any())).thenAnswer(
        (_) async => const Result.success(
          PaginatedResult<ShortManagementEntity>(items: [], hasMore: false),
        ),
      );
    },
    build: () => ViewShortsCubit(getMyShorts),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ViewShortsState.loading(),
      const ViewShortsState.loaded(items: [], hasMore: false, isLoadingMore: false),
    ],
  );

  blocTest<ViewShortsCubit, ViewShortsState>(
    'emits [loading, error] when the repository call fails',
    setUp: () {
      when(() => getMyShorts(any())).thenAnswer(
        (_) async => const Result.failure(ServerErrorException('backend unreachable')),
      );
    },
    build: () => ViewShortsCubit(getMyShorts),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ViewShortsState.loading(),
      const ViewShortsState.error(ServerErrorException('backend unreachable')),
    ],
  );

  blocTest<ViewShortsCubit, ViewShortsState>(
    'removeItem drops the short by id without refetching',
    setUp: () {
      when(() => getMyShorts(any())).thenAnswer(
        (_) async => Result.success(PaginatedResult(items: [short], hasMore: false)),
      );
    },
    build: () => ViewShortsCubit(getMyShorts),
    act: (cubit) async {
      await cubit.load();
      cubit.removeItem('short-1');
    },
    expect: () => [
      const ViewShortsState.loading(),
      ViewShortsState.loaded(items: [short], hasMore: false, isLoadingMore: false),
      const ViewShortsState.loaded(items: [], hasMore: false, isLoadingMore: false),
    ],
    verify: (_) => verify(() => getMyShorts(any())).called(1),
  );
}
