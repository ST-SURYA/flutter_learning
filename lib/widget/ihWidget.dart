import 'package:flutter/material.dart';

class Child2 extends StatefulWidget {
  final int count;
  final Widget child;

  const Child2({
    super.key,
    required this.child,
    this.count = 0,
  });

  @override
  _Child2State createState() => _Child2State();
}

class _Child2State extends State<Child2> {
  int count = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    count = widget.count;
    _controller.text = count.toString();
  }

  void _updateCount(String value) {
    setState(() {
      count = int.tryParse(value) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Ihwidget(
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.blue, width: 3)),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Child 2"),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter new count',
                    ),
                    onChanged: _updateCount,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Current Count: $count',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [widget.child],
            ),
          ],
        ),
      ),
      count: count,
    );
  }
}

class Ihwidget extends InheritedWidget {
  final int count;

  const Ihwidget({
    super.key,
    required Widget child,
    required this.count,
  }) : super(child: child);

  static int of(BuildContext context) {
    final Ihwidget? widget =
        context.dependOnInheritedWidgetOfExactType<Ihwidget>();
    return widget?.count ?? 0;
  }

  @override
  bool updateShouldNotify(Ihwidget oldWidget) {
    return count != oldWidget.count;
  }
}
