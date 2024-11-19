import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // setUp(() {
  //   SharedPreferences.setMockInitialValues({});
  // });
  group('end-to-end test', () {
    testWidgets('login page', (tester) async {
      // await tester.pumpAndSettle();
      app.main();
      await tester.pumpAndSettle();
      final emailField = find.byKey(Key("email"));
      final passwordField = find.byKey(Key("password"));
      final loginBtn = find.byKey(Key("loginButton"));
      await tester.enterText(emailField, "emilys");
      await tester.enterText(passwordField, "emilyspass");
      await tester.pumpAndSettle();
      await tester.tap(loginBtn);
      await Future.delayed(Duration(seconds: 3));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 15));
      // expect(find.text("Welcome, emilys!"), findsOneWidget);
      expect(find.text("Todo"), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('todoBtn')));
      await Future.delayed(Duration(seconds: 5));
      expect(find.text("To-Do List"), findsOneWidget);
      await Future.delayed(Duration(seconds: 15));
      final checkBox = find.byType(Checkbox).first;
      await tester.tap(checkBox);
      expect(
        tester.getSemantics(checkBox),
        matchesSemantics(
            hasTapAction: true,
            hasCheckedState: true,
            isChecked: true,
            hasEnabledState: true,
            isEnabled: true,
            isFocusable: true),
      );
      final deleteBtn = find.byKey(Key('tododelete')).first;
      await tester.tap(deleteBtn);
    });
  });
}
