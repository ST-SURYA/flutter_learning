import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/local_storeage.dart';
import 'package:flutter_application_1/widget/Theme/Theme.dart';
import 'package:get/get.dart';

void main() {
  Get.put(LocalStorage());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeModel();
  }
}
