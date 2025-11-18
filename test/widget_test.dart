
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelio/screens/login_screen.dart';

void main() {
  testWidgets('Login screen loads correctly', (WidgetTester tester) async {
    // Build the LoginScreen widget.
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify the Login Screen text appears.
    expect(find.text("Login Screen"), findsOneWidget);
  });
}
