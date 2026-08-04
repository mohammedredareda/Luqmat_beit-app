import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocalePreferenceStorage extends Mock implements LocalePreferenceStorage {}

void main() {
  late _MockLocalePreferenceStorage storage;

  setUpAll(() {
    registerFallbackValue(const Locale('ar'));
  });

  setUp(() {
    storage = _MockLocalePreferenceStorage();
  });

  test('defaults to Arabic before any locale is loaded', () {
    final cubit = LocaleCubit(storage);
    expect(cubit.state, const Locale('ar'));
    cubit.close();
  });

  blocTest<LocaleCubit, Locale>(
    'loadSavedLocale emits the stored locale when one exists',
    setUp: () {
      when(() => storage.getLocale()).thenAnswer((_) async => const Locale('en'));
    },
    build: () => LocaleCubit(storage),
    act: (cubit) => cubit.loadSavedLocale(),
    expect: () => [const Locale('en')],
  );

  blocTest<LocaleCubit, Locale>(
    'loadSavedLocale falls back to Arabic when nothing is stored',
    setUp: () {
      when(() => storage.getLocale()).thenAnswer((_) async => null);
    },
    build: () => LocaleCubit(storage),
    act: (cubit) => cubit.loadSavedLocale(),
    expect: () => [const Locale('ar')],
  );

  blocTest<LocaleCubit, Locale>(
    'setLocale persists and emits the new locale',
    setUp: () {
      when(() => storage.saveLocale(any())).thenAnswer((_) async {});
    },
    build: () => LocaleCubit(storage),
    act: (cubit) => cubit.setLocale(const Locale('en')),
    expect: () => [const Locale('en')],
    verify: (_) {
      verify(() => storage.saveLocale(const Locale('en'))).called(1);
    },
  );
}
