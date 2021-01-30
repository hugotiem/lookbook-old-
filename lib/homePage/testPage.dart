import 'package:flutter/material.dart';

class ListViewTest extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100,
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(10),
              height: 50,
              color: Colors.amber[colorCodes[index]],
              child: Center(child: Text('Entry ${entries[index]}')),
            );
          }),
    );
  }
}
