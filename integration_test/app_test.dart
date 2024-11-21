import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.text("Welcome, emilys!"), findsOneWidget);
      expect(find.text("Todo"), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('todoBtn')));
      await tester.pump();
      await tester.pumpAndSettle();

      //Todo page

      final firstCheckbox = find.byType(Checkbox).first;
      expect(
          tester.getSemantics(firstCheckbox),
          matchesSemantics(
              hasTapAction: true,
              hasCheckedState: true,
              isChecked: true,
              hasEnabledState: true,
              isEnabled: true,
              isFocusable: true));
      await tester.tap(firstCheckbox);
      await tester.pump();
      await tester.pumpAndSettle();
      expect(
          tester.getSemantics(firstCheckbox),
          matchesSemantics(
              hasTapAction: true,
              hasCheckedState: true,
              isChecked: false,
              hasEnabledState: true,
              isEnabled: true,
              isFocusable: true));

      final addNewField = find.byKey(Key("addNewField"));
      final addNewBtn = find.byKey(Key("addNewBtn"));
      await tester.enterText(addNewField, "Test Task");
      await tester.pump();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.tap(addNewBtn);
      await tester.pump();
      await tester.pumpAndSettle(Duration(seconds: 3));
      // Find the scrollable widget
      await tester.fling(find.byType(ListView), const Offset(0, -500), 1000);
      await tester.pumpAndSettle();

      // Find the scrollable widget
      final scrollableFinder = find.byType(ListView);
      expect(scrollableFinder, findsOneWidget); // Ensure the ListView exists

      // Scroll in small increments until 'Test Task' is visible
      const double scrollStep = 200.0; // Adjust the step size if needed
      bool taskFound = false;

      while (!taskFound) {
        try {
          await tester.scrollUntilVisible(
            find.text('Test Task'),
            scrollStep,
            scrollable: scrollableFinder,
          );
          taskFound = true; // Exit loop if 'Test Task' becomes visible
        } catch (e) {
          // Continue scrolling if not visible yet
          await tester.drag(scrollableFinder, const Offset(0, -scrollStep));
          taskFound = false;
          await tester.pumpAndSettle();
        }
      }

      // Ensure 'Test Task' is now visible
      expect(find.text("Test Task"), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.pump(Duration(seconds: 10));
    });
  });
}
