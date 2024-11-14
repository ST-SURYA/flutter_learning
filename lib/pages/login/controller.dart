import 'package:flutter_application_1/pages/login/login_service.dart';
import 'package:flutter_application_1/router/router.dart';
import 'package:flutter_application_1/util/api_servises.dart';
import 'package:flutter_application_1/widget/common/snackbar.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final LoginService _loginService = LoginService();

  Future<void> formSubmit(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      final user = await _loginService.login(email, password);
      print(user);
      if (user != null) {
        print(ApiService().dio.options.headers);
        Get.toNamed(Routes.dashboard);
      } else {
        Snackbar.showSnackbar(
          title: 'Unauthorized',
          message: 'Login failed',
        );
      }
    }
  }
}
