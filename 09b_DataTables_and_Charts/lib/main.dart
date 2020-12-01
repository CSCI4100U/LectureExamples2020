import 'package:flutter/material.dart';

import 'package:datatables_and_charts/grade_table.dart';
import 'package:datatables_and_charts/paginated_grade_table.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Tables and Charts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: GradesTable(),
      home: PaginatedGradesTable(),
    );
  }
}
