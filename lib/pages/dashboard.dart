import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Home.dart';
import 'package:flutter_application_1/pages/tabDemo.dart';
import 'package:flutter_application_1/widget/menu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Import to decode the JSON response

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  String name = '';

  static const List<Map<String, String>> menu = [
    {"name": "Home", "icon": "home"},
    {"name": "Page 1", "icon": "pageview"},
    {"name": "Page 2", "icon": "book"},
    {"name": "Page 3", "icon": "settings"},
  ];

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final url = Uri.parse("http://172.18.0.7:3016/api/accounts/me");
      final headers = {
        "Content-Type": "application/json",
        "authorization":
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyIkX18iOnsiYWN0aXZlUGF0aHMiOnsicGF0aHMiOnsiZW1haWwiOiJpbml0IiwidXNlck5hbWUiOiJpbml0IiwiX2lkIjoiaW5pdCIsInBhc3N3b3JkIjoiaW5pdCIsImNyZWF0ZWRBdCI6ImluaXQiLCJfX3YiOiJpbml0In0sInN0YXRlcyI6eyJyZXF1aXJlIjp7fSwiaW5pdCI6eyJfaWQiOnRydWUsInVzZXJOYW1lIjp0cnVlLCJlbWFpbCI6dHJ1ZSwicGFzc3dvcmQiOnRydWUsImNyZWF0ZWRBdCI6dHJ1ZSwiX192Ijp0cnVlfX19LCJza2lwSWQiOnRydWV9LCIkaXNOZXciOmZhbHNlLCJfZG9jIjp7Il9pZCI6IjY3MzQ3YWJkN2I0MTIyYmY0OTljYWU2OSIsInVzZXJOYW1lIjoic3VyeWEiLCJlbWFpbCI6InN1cnlhQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoiJDJiJDEwJEJhampVazBPRjI2ZVFhMThPYVk4eE9pNUQyUnpLekdIQjN4Qk9Uc1VMZ3QuclFXWU9NUmJxIiwiY3JlYXRlZEF0IjoiMjAyNC0xMS0xM1QxMDowOTowMS4zNjhaIiwiX192IjowfSwiaWF0IjoxNzMxNDk3MjYwLCJleHAiOjE3MzE1ODM2NjB9.FNSrV7_-Jes35w_ucyenwGoGvtUfFQOOsPJlgMGOARE',
      };

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // Decode the response body to a Map
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Safely access nested values
        setState(() {
          name = responseData['user']?['_doc']?['userName'] ?? 'Unknown User';
        });
      } else {
        print('Failed to fetch user: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  // This method will update the selected index and page when a BottomNavigationBar item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController
        .jumpToPage(index); // Navigate to the respective page in the PageView
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(name),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: <Widget>[
            Center(
              child: Menu(),
            ),
            Center(
              child: MyHomePage(
                title: "",
              ),
            ),
            Center(
              child: TabBarDemo(),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8.0), // Add bottom padding
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 0.0,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.green,
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.black,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.tab_outlined),
                    label: '',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
