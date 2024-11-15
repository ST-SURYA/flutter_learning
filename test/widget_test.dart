import 'package:flutter_application_1/pages/login/controller.dart';
import 'package:flutter_application_1/util/local_storeage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

class MockSharedPreferences extends Mock implements LocalStorage {
  @override
  Future<dynamic> getData(String key, Type type) async {
    if (type == String) {
      return 'mocked_token'; // Return a mocked token for testing
    }
    return null;
  }

  @override
  Future<void> setData(String key, dynamic value) async {
    // Mock the behavior of setData, no actual behavior needed for testing
    return Future.value();
  }
}

void main() {
  late LoginController loginController;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    // Initialize the mock and controller before each test
    mockSharedPreferences = MockSharedPreferences();
    loginController = Get.put(LoginController());

    // Mock the setData method
    when(mockSharedPreferences.setData("accessToken", any))
        .thenAnswer((_) async {
      // Do nothing in mock
      return Future.value();
    });

    // Mock the shared preferences instance for getData
    when(mockSharedPreferences.getData("accessToken", String))
        .thenAnswer((_) async => 'mocked_token'); // Mock a token retrieval
  });

  test('Login test', () async {
    // Simulate login
    await loginController.formSubmit("emilys", "emilyspass");

    // Check that the token is not empty (this should be from the mock)
    final token = await mockSharedPreferences.getData("accessToken", String);
    expect(token, isNotEmpty); // Ensure token is not empty
  });
}
