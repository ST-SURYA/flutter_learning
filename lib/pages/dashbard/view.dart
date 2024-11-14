import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dashbard/controller.dart';
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
            ],
          ),
        ),
      );
    });
  }
}
