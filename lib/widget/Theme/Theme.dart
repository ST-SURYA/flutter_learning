import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/view.dart';
import 'package:flutter_application_1/router/router.dart';
import 'package:flutter_application_1/util/local_storeage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends StatefulWidget {
  const ThemeModel({
    super.key,
  });

  @override
  _ThemeModel createState() => _ThemeModel();
}

class _ThemeModel extends State<ThemeModel> {
  ThemeMode _themeMode = ThemeMode.light;
  String? _initialRoute;

  Future<void> _checkToken() async {
    final token = await LocalStorage.getData("accessToken", String);
    setState(() {
      _initialRoute = token != null ? Routes.dashboard : Routes.login;
    });
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkToken(); // Check token on app launch
  }

  @override
  Widget build(BuildContext context) {
    print(_initialRoute);
    return _initialRoute == null
        ? Center(child: CircularProgressIndicator())
        : ThemeContext(
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
              initialRoute: _initialRoute, // Set initialRoute based on token
              getPages: RouterManagement.getPages(),
            ),
          );
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
