import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Home.dart';
import 'package:flutter_application_1/pages/dashboard.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/tabDemo.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeModel extends StatefulWidget {
  // final Widget child;

  const ThemeModel({
    super.key,
    // required this.child,
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
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 169, 183),
              brightness: Brightness.light,
            ),
            // textTheme:
            //     GoogleFonts.dancingScriptTextTheme(Theme.of(context).textTheme),
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
          routes: {
            'dashboard': (context) => Dashboard(),
            'home': (context) => MyHomePage(title: "Flutter"),
            'tab': (context) => TabBarDemo(),
          },
          home: Login(),
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
