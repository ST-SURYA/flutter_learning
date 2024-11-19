import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/controller.dart';
import 'package:flutter_application_1/pages/login/login_service.dart';
import 'package:flutter_application_1/pages/login/view.dart';
import 'package:flutter_application_1/util/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import '../mock_login_service.dart';

void main() {
  group('Login Widget Test', () {
    late LoginController loginController;
    late MockLoginService mockLoginService;

    setUp(() {
      mockLoginService = MockLoginService();
      loginController = LoginController();
      // loginController.loginService = mockLoginService; // Inject mock
    });

    Future<void> _buildWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Login(),
        ),
      );
    }

    testWidgets('Login UI loads correctly', (WidgetTester tester) async {
      await _buildWidget(tester);
      expect(find.byKey(const Key('loginLabel')), findsOneWidget);
      // Check if email and password fields are present
      expect(find.byKey(const Key('email')), findsOneWidget);
      expect(find.byKey(const Key('password')), findsOneWidget);
      // Check if Login button is present using the key
      expect(find.byKey(const Key('loginButton')), findsOneWidget);
    });

    testWidgets('Login button calls login method', (WidgetTester tester) async {
      await _buildWidget(tester);

      //   // Enter text into email and password fields
      await tester.enterText(
          find.byKey(const Key('email')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('password')), 'password123');

      // Mock successful login response
      when(mockLoginService.login('test@example.com', 'password123'))
          .thenAnswer(
        (_) async => User(
          id: 1,
          username: "test_user",
          email: "test@example.com",
          firstName: "Test",
          lastName: "User",
          gender: "Male",
          image: "https://example.com/image.png",
          accessToken: "sample_access_token",
          refreshToken: "sample_refresh_token",
        ),
      );

      // Tap the login button
      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      // Verify login method was called
      verify(mockLoginService.login('test@example.com', 'password123'))
          .called(1);
    });

    testWidgets('Shows error message on login failure',
        (WidgetTester tester) async {
      await _buildWidget(tester);

      // Enter text into email and password fields
      await tester.enterText(
          find.byKey(const Key('email')), 'test@example.com');
      await tester.enterText(
          find.byKey(const Key('password')), 'wrong_password');

      // Mock failed login response
      when(mockLoginService.login('test@example.com', 'wrong_password'))
          .thenAnswer((_) async => null);

      // Tap the login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify Snackbar is shown with error message
      expect(find.text('Unauthorized'), findsOneWidget);
      expect(find.text('Login failed'), findsOneWidget);
    });

    testWidgets('Navigates to Dashboard on successful login',
        (WidgetTester tester) async {
      await _buildWidget(tester);

      // Enter text into email and password fields
      await tester.enterText(
          find.byKey(const Key('email')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('password')), 'password123');

      // Mock successful login response
      when(mockLoginService.login('test@example.com', 'password123'))
          .thenAnswer(
        (_) async => User(
          id: 1,
          username: "test_user",
          email: "test@example.com",
          firstName: "Test",
          lastName: "User",
          gender: "Male",
          image: "https://example.com/image.png",
          accessToken: "sample_access_token",
          refreshToken: "sample_refresh_token",
        ),
      );

      // Mock Get.toNamed to verify navigation
      final dashboardRoute = '/dashboard';
      Get.testMode = true;

      // Tap the login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(Get.currentRoute, dashboardRoute);
    });
  });
}
