import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalCacheBox.init();
  await configureDependencies();
  runApp(const LuqmatBeitApp());
}
