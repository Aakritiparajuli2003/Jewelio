import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelio/screens/login_screen.dart';
import 'package:jewelio/main.dart';

void main() {
  // Test for LoginScreen
  testWidgets('Login screen loads correctly', (WidgetTester tester) async {
    // Build the LoginScreen widget
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify the Login Screen text appears
    expect(find.text("Login Screen"), findsOneWidget);
  });

  // Test for counter increment in MyApp
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
