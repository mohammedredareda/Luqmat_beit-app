import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'di/injection.dart';

/// `LocalCacheBox.init()` + `configureDependencies()` (Hive box open +
/// `flutter_secure_storage`'s first Keystore read) can take a couple of
/// seconds on-device. Awaiting them before the first `runApp()` call leaves
/// the OS with nothing drawn and no input handler registered for that
/// whole span, which Android reports as an ANR ("لا يستجيب") if the user
/// taps during it. Calling `runApp()` immediately and doing that work in a
/// `FutureBuilder` fixes the ANR without changing what's on screen — this
/// placeholder is the same flat surface color as the real app's background,
/// so there's no visible splash/loading screen, just an ordinary blank frame
/// briefly instead of a frozen one.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const _Bootstrap());
}

class _Bootstrap extends StatefulWidget {
  const _Bootstrap();

  @override
  State<_Bootstrap> createState() => _BootstrapState();
}

class _BootstrapState extends State<_Bootstrap> {
  late final Future<void> _initialization = _initialize();

  Future<void> _initialize() async {
    await LocalCacheBox.init();
    await configureDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ColoredBox(color: AppColors.surfaceLight),
          );
        }
        return const LuqmatBeitApp();
      },
    );
  }
}
