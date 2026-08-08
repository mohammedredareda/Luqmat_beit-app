import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:meta/meta.dart';

/// Local stand-in for `package:bloc_test`'s `blocTest()` — the real package
/// forces the public `test` package to a version whose `analyzer`
/// requirement (>=8.0.0) is incompatible with every `freezed` 2.x release
/// (<7.0.0), and `freezed` 3.x needs a Dart SDK too new for this project's
/// floor. Implements the same `build`/`setUp`/`seed`/`act`/`expect`/`verify`
/// surface this codebase actually uses, using only `flutter_test` (which
/// never pulls in the public `test` package).
@isTest
void blocTest<B extends BlocBase<State>, State>(
  String description, {
  required B Function() build,
  FutureOr<void> Function()? setUp,
  State Function()? seed,
  FutureOr<void> Function(B bloc)? act,
  Iterable Function()? expect,
  FutureOr<void> Function(B bloc)? verify,
}) {
  flutter_test.test(description, () async {
    if (setUp != null) await setUp();
    final bloc = build();
    if (seed != null) {
      // ignore: invalid_use_of_protected_member
      bloc.emit(seed());
    }

    final states = <State>[];
    final subscription = bloc.stream.listen(states.add);

    if (act != null) await act(bloc);
    await flutter_test.pumpEventQueue();
    await subscription.cancel();

    if (expect != null) {
      flutter_test.expect(states, expect());
    }
    if (verify != null) await verify(bloc);

    await bloc.close();
  });
}
