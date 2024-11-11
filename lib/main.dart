import 'package:flutter/material.dart';
import 'package:flutter_application_1/sample.dart';
import 'package:flutter_application_1/widget/layout/listview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 169, 183)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
      ),
      endDrawer: Drawer(
        child: ListViewExample(),
      ),
      drawer: Drawer(
        child: ListViewExample(),
      ),
      body: SingleChildScrollView(
        // Wrap body in SingleChildScrollView to allow scrolling
        child: Column(
          children: <Widget>[
            const Text(
              'Parent',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  crossAxisCount: 1, // 1 row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
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
                  icon:
                      const Icon(Icons.arrow_forward), // Icon on the right side
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
