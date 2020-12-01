import 'package:datatables_and_charts/grade_table.dart';
import 'package:datatables_and_charts/model/GradesSource.dart';
import 'package:flutter/material.dart';

import 'frequency_chart.dart';
import 'model/grade.dart';

class PaginatedGradesTable extends StatefulWidget {
  @override
  _PaginatedGradesTableState createState() => _PaginatedGradesTableState();
}

class _PaginatedGradesTableState extends State<PaginatedGradesTable> {
  GradesDataSource _gradeSource;

  @override
  void initState() {
    super.initState();

    _gradeSource = GradesDataSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grades'),
        actions: [
          IconButton(
            icon: Icon(Icons.insert_chart),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FrequencyChart(
                        grades: _gradeSource.getGrades(),
                      )));
            },
          ),
          IconButton(
            icon: Icon(Icons.table_rows),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GradesTable(),
              ));
            },
          ),
        ],
      ),
      body: PaginatedDataTable(
        header: const Text('Grades'),
        source: _gradeSource,
        // Note: this code works, but Flutter renders too large a footer for portrait mode
        // rowsPerPage: 5,
        // availableRowsPerPage: const <int>[
        //   5,
        //   10,
        // ],
        // onRowsPerPageChanged: (int rowsPerPage) {
        //   print('onRowsPerPageChanged: $rowsPerPage');
        // },
        // onPageChanged: (int rowIndex) {
        //   print('onPageChanged: $rowIndex');
        // },
        columns: const <DataColumn>[
          DataColumn(label: Text('SID')),
          DataColumn(label: Text('Grade')),
        ],
      ),
    );
  }
}
