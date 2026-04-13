import 'package:flutter_test/flutter_test.dart';

import 'package:fast_location/main.dart';

void main() {
  testWidgets('App smoke test — splash screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const FastLocationApp());
    expect(find.text('FastLocation'), findsOneWidget);
  });
}
