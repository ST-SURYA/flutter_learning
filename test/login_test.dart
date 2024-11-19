import 'package:dio/dio.dart';
import 'package:flutter_application_1/pages/login/login_service.dart';
import 'package:flutter_application_1/util/api_servises.dart';
import 'package:flutter_application_1/util/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_test.mocks.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([Dio])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockDio = MockDio();
  final loginService = LoginService();
  final ApiService apiService = ApiService();
  final Dio dio =
      Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  setUp(() {
    // Set up mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
  });

  group('loginUser', () {
    test('returns an access token if the login is successful', () async {
      when(mockDio.post("https://dummyjson.com/auth/login",
              data: anyNamed('data')))
          .thenAnswer(
        (_) async => Response(
          data: {'access_token': 'mock_token'},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final response = await dio.post("/posts", data: {
        "title": 'foo',
        "body": 'bar',
        "userId": 1,
      });
      expect(response, isA<User>());
    });

    test('returns an null if the login is unsuccessful', () async {
      when(mockDio.post("https://dummyjson.com/auth/login",
              data: anyNamed('data')))
          .thenAnswer(
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
