import 'package:flutter/material.dart';

class ScheduledEvent {
  String name;
  DateTime dateTime;

  ScheduledEvent({this.name, this.dateTime});

  String toString() {
    return '$name ($dateTime)';
  }
}

class ScheduleEventPage extends StatefulWidget {
  String title;

  ScheduleEventPage({Key key, this.title}) : super(key: key);

  @override
  _ScheduleEventPageState createState() => _ScheduleEventPageState();
}

class _ScheduleEventPageState extends State<ScheduleEventPage> {
  DateTime _eventDate = DateTime.now();
  String _eventName = '';

  @override
  Widget build(BuildContext context) {
    DateTime rightNow = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(onChanged: (String value) {
            setState(() {
              _eventName = value;
            });
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                child: Text('Choose'),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    firstDate: rightNow,
                    lastDate: DateTime(2100),
                    initialDate: rightNow,
                  ).then((value) {
                    setState(() {
                      // overwrite year/month/day with new values
                      _eventDate = DateTime(
                        value.year,
                        value.month,
                        value.day,
                        _eventDate.hour,
                        _eventDate.minute,
                        _eventDate.second,
                      );
                    });
                  });
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(_toDateString(_eventDate)),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            RaisedButton(
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay(hour: rightNow.hour, minute: rightNow.minute),
                ).then((value) {
                  setState(() {
                    // overwrite hours/minutes with new values, keep date the same
                    _eventDate = DateTime(
                      _eventDate.year,
                      _eventDate.month,
                      _eventDate.day,
                      value.hour,
                      value.minute,
                    );
                  });
                });
              },
              child: Text('Select'),
              color: Colors.blue,
              textColor: Colors.white,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(_toTimeString(_eventDate)),
            ),
          ]),
          Center(
            child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop(
                      ScheduledEvent(name: _eventName, dateTime: _eventDate));
                },
                child: Text('Save')),
          ),
        ],
      ),
    );
  }

  String _twoDigits(int value) {
    if (value < 10) {
      return '0$value';
    } else {
      return '$value';
    }
  }

  String _toDateString(DateTime date) {
    return '${date.year}/${_twoDigits(date.month)}/${_twoDigits(date.day)}';
  }

  String _toTimeString(DateTime date) {
    return '${_twoDigits(date.hour)}:${_twoDigits(date.minute)}';
  }
}
