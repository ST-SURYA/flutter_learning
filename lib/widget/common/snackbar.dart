import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snackbar {
  static void showSnackbar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
    );
  }
}
