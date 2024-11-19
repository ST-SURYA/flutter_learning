import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/controller.dart';
import 'package:flutter_application_1/pages/login/login_service.dart';
import 'package:flutter_application_1/widget/input/textfield.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  final LoginController _loginController = LoginController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(key: const Key('loginLabel'), "Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                key: Key('email'),
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                key: Key('password'),
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 24),
              Obx(() {
                return LoginService().isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        key: const Key('loginButton'),
                        onPressed: () {
                          _loginController.formSubmit(
                              _emailController.text, _passwordController.text);
                        },
                        child: const Text('Login'),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
