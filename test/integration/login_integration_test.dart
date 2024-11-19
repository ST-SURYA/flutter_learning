import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });
  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      await tester.pumpAndSettle();
      app.main();
      await tester.pumpAndSettle();
      final emailField = find.byKey(Key("email"));
      final passwordField = find.byKey(Key("password"));
      final loginBtn = find.byKey(Key("loginButton"));
      await tester.enterText(emailField, "emilys");
      await tester.enterText(passwordField, "emilyspass");
      await tester.pumpAndSettle();
      await tester.tap(loginBtn);
      await tester.pumpAndSettle();
      expect(find.text("emilys"), findsOneWidget);
      await Future.delayed(Duration(seconds: 20));
    });
  });
}
