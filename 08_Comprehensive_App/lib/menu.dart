import 'package:flutter/material.dart';

import 'chore_list.dart';
import 'person_list.dart';

class Menu {
  static List<Widget> createMenu(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.event),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChoreList(title: 'Chores')));
        },
      ),
      IconButton(
        icon: Icon(Icons.people),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PeopleList(title: 'People')));
        },
      ),
    ];
  }
}
