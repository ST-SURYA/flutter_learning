import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  // Observables for form fields
  var username = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;
  var gender = ''.obs;
  var agreeTerms = false.obs;
  var country = ''.obs;
  var obscureText = true.obs;
  // Validation error messages
  var genderError = ''.obs;

  // Form validation key
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // ever(gender, (_) {
    //   validateGenderSelection();
    // });
  }

  void togglePasswordVisibility() => obscureText.value = !obscureText.value;
  // Validation functions
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  String? validateGenderSelection(String? value) {
    if (value == null) {
      return "Please select a gender.";
    }
    return null;
  }

  String? validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a country';
    }
    return null;
  }

  String? validateAgreeTerms(bool value) {
    if (!value) {
      return 'You must agree to the terms and conditions';
    }
    return null;
  }

  // Update user info
  void updateUserInfo() {
    // validateGenderSelection();
    if (formKey.currentState?.validate() ?? false) {
      if (genderError.value.isEmpty) {
        // Proceed with user info update logic
        print('User info updated');
      } else {
        print('Gender validation failed');
      }
    } else {
      print('Validation failed');
    }
  }
}
