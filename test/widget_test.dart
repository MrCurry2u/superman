// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:the_lions_eye/main.dart';

void main() {
  testWidgets('Startup routes to consent when terms not accepted', (WidgetTester tester) async {
    // Ensure SharedPreferences is mocked and empty for this test
    SharedPreferences.setMockInitialValues(<String, Object>{});

    // Build app
    await tester.pumpWidget(const TheLionsEyeApp());

    // Startup shows a progress indicator while checking consent
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for async startup to finish and navigation to occur (poll)
    for (var i = 0; i < 50; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      if (find.text('User Agreement').evaluate().isNotEmpty) break;
    }

    // Default test environment should route to Consent screen when not accepted
    expect(find.text('User Agreement'), findsOneWidget);
  });
}
