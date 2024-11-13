import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Home.dart';

class Menu extends StatelessWidget {
  static const List<Map<String, String>> menu = [
    {"name": "dashboard", "icon": "dashboard", "route": "dashboard"},
    {"name": "Home", "icon": "home", "route": "home"},
    {"name": "Tab", "icon": "book", "route": "tab"},
    {"name": "Page 3", "icon": "settings"},
  ];
  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'dashboard':
        return Icons.dashboard;
      case 'book':
        return Icons.book;
      case 'settings':
        return Icons.settings;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: menu.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: Icon(_getIcon(item['icon']!)),
            title: Text(item['name']!),
            onTap: () {
              Navigator.pushNamed(context, item["route"] ?? "");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => MyHomePage(
              //             title: "flutter",
              //           )),
              // );
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text('${item['name']} clicked!')),
              // );
            },
          ),
        );
      }).toList(),
    );
  }
}
