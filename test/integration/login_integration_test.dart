import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart' as app;
import 'package:flutter_application_1/pages/login/login_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final MockApiService mockApiService = MockApiService();
  final loginService = LoginService(apiService: mockApiService);

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
      final mockDio = MockDio();

      // Stub the `dioInstance` method to return the mock Dio
      when(mockApiService.dio).thenReturn(mockDio);
      when(mockDio.post("/auth/login", data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          data: {
            "id": 1,
            "username": "emilys",
            "email": "emily.johnson@x.dummyjson.com",
            "firstName": "Emily",
            "lastName": "Johnson",
            "gender": "female",
            "image": "https://dummyjson.com/icon/emilys/128",
            "accessToken":
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...", // JWT accessToken (for backward compatibility) in response and cookies
            "refreshToken":
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." // refreshToken in response and cookies
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(loginBtn);
      await tester.pumpAndSettle();
      expect(find.text("emilys"), findsOneWidget);
      await Future.delayed(Duration(seconds: 20));
    });
  });
}
