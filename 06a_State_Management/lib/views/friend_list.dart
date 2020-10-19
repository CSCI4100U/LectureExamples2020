import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/friends.dart';

class FriendListWidget extends StatelessWidget {
  FriendListWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // obtain the FriendsBLoC
    final FriendListBLoC friendListBLoC = context.watch<FriendListBLoC>();
    // print(friendListBLoC.friends);

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: friendListBLoC.friends.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: Text('${friendListBLoC.friends[index]}'),
        );
      },
    );
  }
}
