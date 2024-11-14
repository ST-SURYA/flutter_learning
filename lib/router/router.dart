import 'package:flutter_application_1/pages/dashbard/view.dart';
import 'package:flutter_application_1/pages/login/view.dart';
import 'package:get/get.dart';

class RouterManagement {
  static List<GetPage> getPages() {
    return [
      GetPage(name: Routes.login, page: () => Login()),
      GetPage(name: Routes.dashboard, page: () => Dashboard()),
    ];
  }
}

class Routes {
  static const login = "/login";
  static const dashboard = "/dashboard";
}
