import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/ihWidget.dart';

class Child3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int valueFromInheritedWidget = Ihwidget.of(context);

    return (Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.blue, width: 3)),
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Column(
            children: [
              Text("Child 3"),
              Text("Value from child 2 : " +
                  valueFromInheritedWidget.toString()),
            ],
          ),
        )));
  }
}
