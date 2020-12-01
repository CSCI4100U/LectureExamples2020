import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'model/grade.dart';

class FrequencyChart extends StatefulWidget {
  final List<Grade> grades;

  FrequencyChart({Key key, this.grades}) : super(key: key);

  @override
  _FrequencyChartState createState() => _FrequencyChartState();
}

class _FrequencyChartState extends State<FrequencyChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grade Frequencies'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 500.0,
          child: charts.BarChart(
            [
              charts.Series<GradeFrequency, String>(
                id: 'Grade Frequency',
                colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                domainFn: (GradeFrequency gf, _) => gf.grade,
                measureFn: (GradeFrequency gf, _) => gf.frequency,
                data: _calculateGradeFrequencies(),
              ),
            ],
            animate: true,
            vertical: true,
          ),
        ),
      ),
    );
  }

  List<GradeFrequency> _calculateGradeFrequencies() {
    var frequencies = {
      'A+': 0,
      'A': 0,
      'A-': 0,
      'B+': 0,
      'B': 0,
      'B-': 0,
      'C+': 0,
      'C': 0,
      'C-': 0,
      'D': 0,
      'F': 0,
    };

    for (Grade grade in widget.grades) {
      frequencies[grade.grade]++;
    }

    var grades = ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F'];
    return grades.map((grade) => GradeFrequency(
      grade: grade,
      frequency: frequencies[grade],
    )).toList();
  }
}
