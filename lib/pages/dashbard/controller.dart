import 'package:flutter_application_1/pages/dashbard/dashboard_services.dart';
import 'package:flutter_application_1/router/router.dart';
import 'package:flutter_application_1/util/api_servises.dart';
import 'package:flutter_application_1/util/local_storeage.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final DashboardServices dashboardServices = DashboardServices();
  var userData = Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  Future<void> fetchUser() async {
    final user = await dashboardServices.getUser();
    if (user != null) {
      userData.value = user as Map<String, dynamic>?;
    }
  }

  Future<void> logoutUser() async {
    await LocalStorage.clearAllData();
    ApiService().clearAccessToken();
    Get.offAllNamed(Routes.login);
  }
}
