import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:state_management/model/friends.dart';

import 'views/add_friend.dart';
import 'views/friend_list.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FriendListBLoC()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'State Management'),
      routes: <String, WidgetBuilder>{
        '/addFriend': (BuildContext context) =>
            AddFriendWidget(title: 'Add Friend'),
        '/friendList': (BuildContext context) =>
            FriendListWidget(title: 'Friend List'),
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddFriendWidget,
          ),
        ],
      ),
      body: FriendListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFriendWidget,
        tooltip: 'Add Friend',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddFriendWidget() async {
    var friend = await Navigator.pushNamed(context, '/addFriend');

    print('New item: $friend');
  }
}
