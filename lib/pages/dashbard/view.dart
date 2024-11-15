import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dashbard/controller.dart';
import 'package:flutter_application_1/pages/todo/view.dart';
import 'package:flutter_application_1/router/router.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final userData = dashboardController.userData.value;
      final username = userData?["username"] ?? "User";
      final imageUrl = userData?["image"];

      return Scaffold(
        appBar: AppBar(
          title: Text(username),
          leading: imageUrl != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 20,
                )
              : Icon(Icons.account_circle),
          actions: [
            IconButton(
                onPressed: dashboardController.logoutUser,
                icon: Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome, $username!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20.0),
              ListTile(
                leading: Icon(Icons.task), // display in starting
                trailing: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward), // Icon on the right side
                  onPressed: () {
                    Get.toNamed(Routes.todo);
                  },
                ), // display in end
                title: Text('Todo'),
                subtitle: Text('Plan your work'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
