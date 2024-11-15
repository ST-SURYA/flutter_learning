import 'package:flutter_application_1/util/api_servises.dart';

class DashboardServices {
  final ApiService apiService = ApiService();
  Future<Map<String, dynamic>?> getUser() async {
    try {
      final user = await apiService.dio.get("/auth/me");
      return user.data;
    } catch (e) {
      print("Error on user : $e");
      return null;
    }
  }
}
