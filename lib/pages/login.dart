import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/input/textfield.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email = "";
  String password = "";

  final _formKey = GlobalKey<FormState>();

  // Simple validation logic for email and password
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length == 0) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final url = Uri.parse("http://172.18.0.7:3016/api/auth/login");
      final headers = {"Content-Type": "application/json"};
      final body = jsonEncode({
        "email": _emailController.text,
        "password": _passwordController.text,
      });

      try {
        final response = await http.post(url, headers: headers, body: body);
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);

          // Safely access the token from the map
          final token = data['token'];
          if (token != null) {
            Navigator.pushNamed(context, "dashboard", arguments: token);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Login successful, but no token found.")),
            );
          }
        } else {
          print("Login failed: ${response.statusCode}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login failed: ${response.body}")),
          );
        }
      } catch (e) {
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                controller: _emailController,
                hintText: "Email",
                onChange: (String val) => setState(() {
                  email = val;
                }),
                validator: validateEmail,
              ),
              const SizedBox(height: 16),
              CommonTextField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true, // To hide the password
                onChange: (String val) => setState(() {
                  password = val;
                }),
                validator: validatePassword,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
