import 'package:flutter/material.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snackbars and Notifications',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'Snackbars and Notifications'),
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
  final _formKey = GlobalKey<FormState>();
  final _notifications = Notifications();

  String _title;
  String _body;
  String _payload;

  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    _notifications.init();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _showPendingNotifications,
          ),
        ],
      ),
      body: Builder(
        builder: _formBuilder,
      ),
    );
  }

  Future<void> _showPendingNotifications() async {
    var pendingNotificationRequests =
        await _notifications.getPendingNotificationRequests();
    print('Pending notifications:');
    for (var pendingRequest in pendingNotificationRequests) {
      print(
          '${pendingRequest.id}/${pendingRequest.title}/${pendingRequest.body}');
    }
  }

  Widget _formBuilder(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Title'),
            onChanged: (String value) {
              _title = value;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Body'),
            onChanged: (String value) {
              _body = value;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Payload'),
            onChanged: (String value) {
              _payload = value;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () {
                  _notifications.sendNotificationNow(_title, _body, _payload);
                },
                child: Text('Now'),
              ),
              RaisedButton(
                onPressed: () async {
                  var when = tz.TZDateTime.now(tz.local)
                      .add(const Duration(seconds: 3));
                  await _notifications.sendNotificationLater(
                      _title, _body, when, _payload);
                  var snackbar =
                      SnackBar(content: Text('Notification set for 3s'));
                  Scaffold.of(context).showSnackBar(snackbar);
                },
                child: Text('In 3s'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
