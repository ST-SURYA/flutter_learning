import 'package:flutter/material.dart';

class ListViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Give the ListView a fixed height
      child: ListView(
        children: List.generate(20, (index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text('Item $index'),
            subtitle: Text('Subtitle for Item $index'),
            onTap: () {
              print('Item $index tapped');
            },
          );
        }),
      ),
    );
  }
}
