import 'package:dio/dio.dart';
import 'package:flutter_application_1/pages/login/login_service.dart';
import 'package:flutter_application_1/util/api_servises.dart';
import 'package:flutter_application_1/util/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_test.mocks.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([Dio, ApiService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final MockApiService mockApiService = MockApiService();
  final loginService = LoginService(apiService: mockApiService);
  final Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.1.191:3000"));

  setUp(() {
    // Set up mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
  });

  group('loginUser', () {
    test('returns an access token if the login is successful', () async {
      // Create a mock Dio instance
      final mockDio = MockDio();

      // Stub the `dioInstance` method to return the mock Dio
      when(mockApiService.dio).thenReturn(mockDio);
      when(mockDio.get("/users", data: anyNamed('data'))).thenAnswer(
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

      final response = await loginService.login('emilys', 'emilyspass');

      expect(response, isA<dynamic>());
    });

    test('returns an null if the login is unsuccessful', () async {
      final mockDio = MockDio();

      // Stub the `dioInstance` method to return the mock Dio
      when(mockApiService.dio).thenReturn(mockDio);
      when(mockDio.get("/users", data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          data: {'message': 'Invalid credentials'},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final response = await loginService.login('emilys', 'emilyspass');
      expect(response, null);
    });
  });
}
