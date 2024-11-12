import 'package:flutter/material.dart';
import 'package:flutter_application_1/sample.dart';
import 'package:flutter_application_1/widget/Theme/Theme.dart';
import 'package:flutter_application_1/widget/layout/listview.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isLocationOn = false;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              ThemeContext.of(context).themeMode == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              final theme = ThemeContext.of(context);
              // // Toggle the theme mode
              if (theme.themeMode == ThemeMode.dark) {
                theme.changeTheme(ThemeMode.light);
              } else {
                theme.changeTheme(ThemeMode.dark);
              }
            },
          ),
        ],
      ),

      // endDrawer: Drawer(
      //   child: ListViewExample(),
      // ),
      drawer: Drawer(
        child: ListViewExample(),
      ),
      body: SingleChildScrollView(
          // Wrap body in SingleChildScrollView to allow scrolling
          child: Stack(
        children: [
          Column(
            children: <Widget>[
              Text(
                'Parent',
                style: GoogleFonts.dancingScript(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('Increment'),
              ),
              Child1(inc: _incrementCounter, parentValue: _counter),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 200, // Optional: set the height for the horizontal grid
                child: GridView.builder(
                  scrollDirection:
                      Axis.horizontal, // Horizontal scrolling enabled
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 1 row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.blueAccent,
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 30),
              // Repeat the content to demonstrate scrolling
              for (int i = 0; i < 20; i++)
                ListTile(
                  leading: Icon(Icons.person), // display in starting
                  trailing: IconButton(
                    icon: const Icon(
                        Icons.arrow_forward), // Icon on the right side
                    onPressed: () {
                      // Perform the action when the icon is tapped
                      print('Icon for Item $i tapped');
                    },
                  ), // display in end
                  title: Text('Item $i'),
                  subtitle: Text('Subtitle for Item $i'),
                  onTap: () {
                    print('Item $i tapped');
                  },
                ),
              // Text(
              //   'Repeated content $i',
              //   style: TextStyle(fontSize: 18),
              // ),
              // const SizedBox(height: 20), // Optional space before ListView
              // Container(
              //   height: 300, // Fixed height for ListView
              //   child: ListViewExample(),
              // ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0, // Add this to stretch the container across the full width
            child: Container(
              height: 75.0,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Aligns the icon to the right
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _isLocationOn = !_isLocationOn;
                    }),
                    child: Icon(
                      _isLocationOn ? Icons.location_on : Icons.location_off,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
