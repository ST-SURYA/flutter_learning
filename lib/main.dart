import 'package:flutter/material.dart';
import 'package:flutter_application_1/sample.dart';
import 'package:flutter_application_1/widget/Theme/Theme.dart';
import 'package:flutter_application_1/widget/layout/listview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeModel();
  }
}
