import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/profile/controller.dart';
import 'package:flutter_application_1/util/type/form_string.dart';
import 'package:flutter_application_1/widget/input/RadioField.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/pages/profile/widget/common.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          return Form(
            key: profileController.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Username field
                  buildTextField(
                    name: FormString.NAME,
                    initialValue: profileController.username.value,
                    labelText: "Username",
                    onChanged: (value) =>
                        profileController.username.value = value!,
                    validator: profileController.validateUsername,
                  ),
                  SizedBox(height: 16.0),

                  // Email field
                  buildTextField(
                    name: FormString.EMAIL,
                    initialValue: profileController.email.value,
                    labelText: "Email",
                    onChanged: (value) =>
                        profileController.email.value = value!,
                    validator: profileController.validateEmail,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Gender:'),
                      RadioFormField<String>(
                        options: [
                          FormFieldOption(
                              value: FormString.MALE, label: "Male"),
                          FormFieldOption(
                              value: FormString.FEMALE, label: "Female"),
                        ],
                        validator: profileController.validateGenderSelection,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) =>
                            profileController.gender.value = value!,
                      ),
                    ],
                  ),
                  // Password field
                  buildPasswordField(
                      name: FormString.PASSWORD,
                      initialValue: profileController.password.value,
                      labelText: "Password",
                      onChanged: (value) =>
                          profileController.password.value = value!,
                      obscureText: profileController.obscureText.value,
                      togglePasswordVisibility:
                          profileController.togglePasswordVisibility,
                      validator: profileController.validatePassword),
                  SizedBox(height: 16.0),

                  // Phone number field
                  buildTextField(
                    name: FormString.PHONE,
                    initialValue: profileController.phoneNumber.value,
                    labelText: "Phone Number",
                    onChanged: (value) =>
                        profileController.phoneNumber.value = value!,
                    validator: profileController.validatePhoneNumber,
                  ),
                  SizedBox(height: 16.0),

                  // Country Dropdown
                  DropdownButtonFormField<String>(
                    value: profileController.country.value.isEmpty
                        ? null
                        : profileController.country.value,
                    items: FormString.COUNTRIES
                        .map((country) => DropdownMenuItem(
                              value: country,
                              child: Text(country),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        profileController.country.value = value!,
                    decoration: InputDecoration(labelText: 'Country'),
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    validator: profileController.validateCountry,
                  ),
                  SizedBox(height: 16.0),

                  // Terms and Conditions Checkbox
                  Row(
                    children: [
                      Obx(() => Checkbox(
                            value: profileController.agreeTerms.value,
                            onChanged: (value) =>
                                profileController.agreeTerms.value = value!,
                          )),
                      const Expanded(
                          child: Text('I agree to the terms and conditions')),
                    ],
                  ),
                  Text(
                    profileController.validateAgreeTerms(
                            profileController.agreeTerms.value) ??
                        '',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),

                  const SizedBox(height: 32.0),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      profileController.updateUserInfo();
                    },
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
