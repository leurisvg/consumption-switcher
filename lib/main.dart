import 'package:flutter/material.dart';
import 'package:consumption_switcher/consumption_switcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumption Switcher',
      debugShowCheckedModeBanner: false,
      home: ConsumptionSwitcher(
        onChanged: (bool value) {
          print(value);
        },
      ),
    );
  }
}
