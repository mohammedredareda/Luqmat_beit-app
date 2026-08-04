import 'package:cook_app/app.dart';
import 'package:cook_app/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  // flutter_secure_storage has no platform implementation in widget tests;
  // stub its channel so LocaleCubit.loadSavedLocale() resolves cleanly
  // instead of throwing MissingPluginException.
  const secureStorageChannel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, (call) async => null);
    configureDependencies();
  });

  testWidgets('builds MaterialApp.router with Arabic as the default locale', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(CookApp());
      // Two pumps: one to build, one to let the fake data source's Future
      // resolve past the loading skeleton — deliberately not pumpAndSettle,
      // since the skeleton's shimmer runs an unbounded repeating animation.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.locale, const Locale('ar'));
      expect(find.text('قائمتي'), findsOneWidget);
    });
  });
}
