import 'package:flutter_application_1/util/api_servises.dart';
import 'package:flutter_application_1/util/local_storeage.dart';
import 'package:get/get.dart';

class LoginService {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await apiService.dio
          .post("/auth/login", data: {"username": email, "password": password});
      isLoading.value = false;
      final String? token = response.data?["accessToken"];
      if (token!.isNotEmpty) {
        LocalStorage().setData("accessToken", token);
      }
      return response.data;
    } catch (e) {
      print("Error on login : $e");
      return null;
    }
  }
}
