import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/view.dart';
import 'package:flutter_application_1/router/router.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeModel extends StatefulWidget {
  const ThemeModel({
    super.key,
  });

  @override
  _ThemeModel createState() => _ThemeModel();
}

class _ThemeModel extends State<ThemeModel> {
  ThemeMode _themeMode = ThemeMode.light;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (ThemeContext(
        themeMode: _themeMode,
        changeTheme: changeTheme,
        child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 169, 183),
              brightness: Brightness.light,
            ),
            brightness: Brightness.light,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 169, 183),
              brightness: Brightness.dark,
            ),
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          themeMode: _themeMode,
          initialRoute: Routes.login,
          getPages: RouterManagement.getPages(),
        )));
  }
}

class ThemeContext extends InheritedWidget {
  final ThemeMode themeMode;
  final void Function(ThemeMode) changeTheme;
  const ThemeContext(
      {super.key,
      required Widget child,
      required this.themeMode,
      required this.changeTheme})
      : super(child: child);

  static dynamic of(BuildContext context) {
    final ThemeContext? widget =
        context.dependOnInheritedWidgetOfExactType<ThemeContext>();
    return (
      themeMode: widget?.themeMode ?? ThemeMode.light,
      changeTheme: widget?.changeTheme
    );
  }

  @override
  bool updateShouldNotify(ThemeContext oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
