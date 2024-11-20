import 'package:flutter_application_1/util/api_servises.dart';
import 'package:flutter_application_1/util/local_storeage.dart';
import 'package:flutter_application_1/util/models/user_model.dart';
import 'package:get/get.dart';

class LoginService {
  final ApiService apiService;
  var isLoading = false.obs;

  LoginService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  Future<dynamic?> login(String email, String password) async {
    try {
      isLoading.value = true;
      // final response = await apiService.dio
      //     .post("/auth/login", data: {"username": email, "password": password});
      final response = await apiService.dio.get('/users');
      final List<dynamic> users = response.data;
      final user = users.firstWhere(
        (user) => user['username'] == email && user['password'] == password,
        orElse: () => null,
      );
      isLoading.value = false;
      // final String? token = response.data?["accessToken"];
      // if (token!.isNotEmpty) {
      //   LocalStorage().setData("accessToken", token);
      // }
      print(user);
      return user;
    } catch (e) {
      // print("Error on login : $e");
      return null;
    }
  }
}
