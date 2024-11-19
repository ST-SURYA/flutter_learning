import 'package:flutter_application_1/pages/login/login_service.dart';
import 'package:flutter_application_1/util/models/user_model.dart';
import 'package:mockito/mockito.dart';

class MockLoginService extends Mock implements LoginService {
  @override
  Future<User?> login(String email, String password) {
    // Return a dummy user as a future
    return Future.value(
      User(
        id: 1,
        username: 'test_user',
        email: email,
        firstName: 'Test',
        lastName: 'User',
        gender: 'Male',
        image: '',
        accessToken: 'dummy_access_token',
        refreshToken: 'dummy_refresh_token',
      ),
    );
  }
}
