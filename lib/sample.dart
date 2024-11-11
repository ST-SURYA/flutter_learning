import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/child3.dart';
import 'package:flutter_application_1/widget/ihWidget.dart';

class Child1 extends StatefulWidget {
  final VoidCallback inc;
  final int parentValue;
  const Child1({super.key, required this.inc, required this.parentValue});

  @override
  _SampleButtonState createState() => _SampleButtonState();
}

class _SampleButtonState extends State<Child1> {
  int _count = 0;

  // Increment the internal counter and call the parent's function
  void _incrementCounter() {
    setState(() {
      _count++;
    });
    // widget.inc(); // Call the function passed from the parent
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2), // Red border
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Child 1",
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            'Counter: $_count',
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Text('Value from parent : ' + widget.parentValue.toString()),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('Increment val: $_count'),
          ),
          Child2(
            child: Child3(),
          ),
        ],
      ),
    );
  }
}
