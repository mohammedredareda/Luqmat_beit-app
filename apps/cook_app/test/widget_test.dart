import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:cook_app/app.dart';
import 'package:cook_app/di/injection.dart';

import 'support/hive_test_init.dart';

void main() {
  const secureStorageChannel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, (call) async => null);
    // Real file I/O (Hive) can't resolve inside a testWidgets zone — this
    // setUpAll callback runs in the normal async zone, same pattern as
    // app_test.dart/app_router_test.dart.
    await initHiveForTest();
    configureDependencies();
  });

  testWidgets('CookApp builds without throwing', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(CookApp());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
