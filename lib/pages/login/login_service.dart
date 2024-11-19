import 'package:flutter_application_1/util/api_servises.dart';
import 'package:flutter_application_1/util/local_storeage.dart';
import 'package:flutter_application_1/util/models/user_model.dart';
import 'package:get/get.dart';

class LoginService {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Future<User?> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await apiService.dio
          .post("/auth/login", data: {"username": email, "password": password});
      isLoading.value = false;
      final String? token = response.data?["accessToken"];
      if (token!.isNotEmpty) {
        LocalStorage().setData("accessToken", token);
      }
      return User.fromJson(response.data);
    } catch (e) {
      print("Error on login : $e");
      return null;
    }
  }
}
