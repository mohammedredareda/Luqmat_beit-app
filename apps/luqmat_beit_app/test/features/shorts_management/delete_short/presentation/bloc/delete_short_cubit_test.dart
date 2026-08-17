import '../../../../../support/bloc_test_helper.dart';
import 'package:luqmat_beit_app/features/shorts_management/delete_short/domain/usecases/delete_short.dart';
import 'package:luqmat_beit_app/features/shorts_management/delete_short/presentation/bloc/delete_short_cubit.dart';
import 'package:luqmat_beit_app/features/shorts_management/delete_short/presentation/bloc/delete_short_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDeleteShort extends Mock implements DeleteShort {}

void main() {
  late _MockDeleteShort deleteShort;

  setUp(() {
    deleteShort = _MockDeleteShort();
  });

  blocTest<DeleteShortCubit, DeleteShortState>(
    'confirm to delete emits [submitting, success(shortId)]',
    setUp: () {
      when(() => deleteShort('short-1')).thenAnswer((_) async => const Result.success(null));
    },
    build: () => DeleteShortCubit(deleteShort),
    act: (cubit) => cubit.delete('short-1'),
    expect: () => [
      const DeleteShortState.submitting(),
      const DeleteShortState.success('short-1'),
    ],
  );

  blocTest<DeleteShortCubit, DeleteShortState>(
    'emits [submitting, failure] when the repository call fails',
    setUp: () {
      when(() => deleteShort('short-1')).thenAnswer(
        (_) async => const Result.failure(ServerErrorException('backend unreachable')),
      );
    },
    build: () => DeleteShortCubit(deleteShort),
    act: (cubit) => cubit.delete('short-1'),
    expect: () => [
      const DeleteShortState.submitting(),
      const DeleteShortState.failure(ServerErrorException('backend unreachable')),
    ],
  );
}
