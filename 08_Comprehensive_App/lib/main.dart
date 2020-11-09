import 'package:flutter/material.dart';

import 'daily_schedule.dart';
import 'person_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chorganizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PeopleList(title: 'People'),
    );
  }
}
