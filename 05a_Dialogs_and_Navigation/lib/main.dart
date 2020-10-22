import 'package:flutter/material.dart';

import 'custom_dialog.dart';
import 'schedule_event.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dialogs and Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Dialogs and Navigation'),
      routes: <String, WidgetBuilder>{
        '/scheduleEvent': (BuildContext context) =>
            ScheduleEventPage(title: 'Schedule Event')
      },
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: RaisedButton(
                child: Text('Alert'),
                onPressed: () {
                  _showAlert(context);
                },
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: RaisedButton(
                child: Text('Choice'),
                onPressed: () {
                  _showSimpleDialog(context);
                },
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: RaisedButton(
                child: Text('About'),
                onPressed: () {
                  _showAboutDialog(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: RaisedButton(
                child: Text('Custom'),
                onPressed: () {
                  _customDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showEventScheduler,
        tooltip: 'Schedule Event',
        child: Icon(Icons.schedule_outlined),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Visitors Tax'),
          content: Text(
              'The city of Barcelona charges each visitor a tax of 5.00 EUR'),
          actions: <Widget>[
            FlatButton(
              child: Text('I Understand'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSimpleDialog(BuildContext context) async {
    var veganRequired = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Vegan?'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Yes, vegan'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            SimpleDialogOption(
              child: Text('No, cheese yum'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
    print('Simple dialog result: $veganRequired');
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Dialogs and Navigation',
      applicationVersion: 'Version 0.1.1',
      children: [
        Text('Dialogs and Navigation'),
        Text('Copyright 2020 - Some Person'),
      ],
    );
  }
  
  void _customDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialog();
      },
    );
  }

  Future<void> _showEventScheduler() async {
    var event = await Navigator.pushNamed(context, '/scheduleEvent');
    print('New event: $event');
  }
}
