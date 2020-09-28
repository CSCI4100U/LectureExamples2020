import 'package:flutter/material.dart';

import 'tab_page.dart';
import 'list_view.dart';
import 'grid_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'More Layouts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'More Layouts'),
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
    List<LayoutExample> options = <LayoutExample>[
      LayoutExample(
        title: 'Column',
        icon: Icons.view_column,
        builder: buildColumnWidget,
      ),
      LayoutExample(
        title: 'Row',
        icon: Icons.reorder,
        builder: buildRowWidget,
      ),
      LayoutExample(
        title: 'Stack',
        icon: Icons.filter_none,
        builder: buildStackWidget,
      ),
      LayoutExample(
        title: 'ListView',
        icon: Icons.view_list,
        builder: buildListView,
      ),
      LayoutExample(
        title: 'GridView',
        icon: Icons.grid_on,
        builder: buildGridView,
      ),
    ];

    return DefaultTabController(
      length: options.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: buildTabBar(options),
        ),
        body: buildTabBarView(options),
      ),
    );
  }

  Widget buildStackWidget() {
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

  Widget buildRowWidget() {
    return Container(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 80.0,
            color: Colors.red,
          ),
          Container(
            width: 80.0,
            color: Colors.blue,
          ),
          Container(
            width: 80.0,
            color: Colors.green,
          ),
          Container(
            width: 80.0,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget buildColumnWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FlutterLogo(
          size: 40.0,
          colors: Colors.red,
        ),
        FlutterLogo(
          size: 40.0,
          colors: Colors.blue,
        ),
        FlutterLogo(
          size: 40.0,
          colors: Colors.green,
        ),
        FlutterLogo(
          size: 40.0,
          colors: Colors.amber,
        ),
      ],
    );
  }
}
