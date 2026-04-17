import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:aether/main.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();
    await Hive.openBox('aetherBox');
  });

  testWidgets('App loads and shows empty state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AetherApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Check app title
    expect(find.text('Aether'), findsOneWidget);

    // Check empty state
    expect(find.text('No data yet'), findsOneWidget);
  });

  testWidgets('Add item works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AetherApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Tap FAB
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Check if item added
    expect(find.text('Item 1'), findsOneWidget);
  });
}