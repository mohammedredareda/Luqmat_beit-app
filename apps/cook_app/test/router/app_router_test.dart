import 'package:cook_app/app.dart';
import 'package:cook_app/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../support/hive_test_init.dart';

void main() {
  const secureStorageChannel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, (call) async => null);
    await initHiveForTest();
    configureDependencies();
  });

  testWidgets('all four bottom-nav destinations navigate without throwing', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(CookApp());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.byType(NavigationBar), findsOneWidget);

      for (final label in ['الطلبات', 'العروض', 'حسابي', 'القائمة']) {
        await tester.tap(find.text(label));
        await tester.pump();
        expect(tester.takeException(), isNull);
      }
    });
  });
}
