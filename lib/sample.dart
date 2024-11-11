import 'package:flutter/material.dart';

class SampleButton extends StatefulWidget {
  final VoidCallback inc;
  const SampleButton({super.key, required this.inc});

  @override
  _SampleButtonState createState() => _SampleButtonState();
}

class _SampleButtonState extends State<SampleButton> {
  int _count = 0;

  // Increment the internal counter and call the parent's function
  void _incrementCounter() {
    // setState(() {
    //   _count++;
    // });
    widget.inc(); // Call the function passed from the parent
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
            'Counter: $_count',
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('Increment val: $_count'),
          ),
        ],
      ),
    );
  }
}
