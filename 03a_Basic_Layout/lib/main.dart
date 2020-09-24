import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BasicLayout(title: 'Basic Layout'),
    );
  }
}

class BasicLayoutStateless extends StatelessWidget {
  BasicLayoutStateless({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Hello world!'));
  }
}

class BasicLayout extends StatefulWidget {
  BasicLayout({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BasicLayoutState createState() => _BasicLayoutState();
}

class _BasicLayoutState extends State<BasicLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildStackWidget(),
    );
  }

  Widget _buildStackWidget() {
    return Stack(
      alignment: const Alignment(1.0, -0.5),
      children: <Widget>[
        CircleAvatar(
          radius: 100.0,
          backgroundColor: Colors.blue,
          child: Text(
            'RF',
            textScaleFactor: 4.0,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black45,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text('Randy',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildRowWidget() {
    return Row(
      children: <Widget>[],
    );
  }
}
