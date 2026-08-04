import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('renders heading, body, and CTA, and CTA fires the callback',
      (tester) async {
    var ctaTapped = false;

    await tester.pumpWidget(wrap(
      EmptyState(
        icon: Icons.soup_kitchen,
        iconBackgroundColor: Colors.orange,
        iconColor: Colors.brown,
        heading: 'قائمتك فارغة',
        body: 'ابدأ بإضافة أول وجبة لمطبخك ليراها الزبائن.',
        ctaLabel: 'إضافة وجبة',
        onCtaPressed: () => ctaTapped = true,
      ),
    ));

    expect(find.text('قائمتك فارغة'), findsOneWidget);
    expect(find.text('ابدأ بإضافة أول وجبة لمطبخك ليراها الزبائن.'), findsOneWidget);
    expect(find.text('إضافة وجبة'), findsOneWidget);

    await tester.tap(find.text('إضافة وجبة'));
    await tester.pump();

    expect(ctaTapped, isTrue);
  });

  testWidgets('renders without a CTA when none is provided', (tester) async {
    await tester.pumpWidget(wrap(
      const EmptyState(
        icon: Icons.inbox_outlined,
        iconBackgroundColor: Colors.grey,
        iconColor: Colors.black,
        heading: 'Nothing here',
        body: 'Nothing to show yet.',
      ),
    ));

    expect(find.byType(ElevatedButton), findsNothing);
  });
}
