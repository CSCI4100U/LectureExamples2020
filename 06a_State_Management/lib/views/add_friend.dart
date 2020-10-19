import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/friends.dart';

class AddFriendWidget extends StatefulWidget {
  AddFriendWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddFriendWidgetState createState() => _AddFriendWidgetState();
}

class _AddFriendWidgetState extends State<AddFriendWidget> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    final FriendListBLoC friendListBLoC = Provider.of<FriendListBLoC>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'First name',
              ),
              onChanged: (String value) {
                _firstName = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Last name',
              ),
              onChanged: (String value) {
                _lastName = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'E-Mail',
                hintText: 'someone@email.com',
              ),
              onChanged: (String value) {
                _email = value;
              },
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                Friend newFriend = Friend(
                  firstName: _firstName,
                  lastName: _lastName,
                  email: _email,
                );
                friendListBLoC.addFriend(newFriend);
                Navigator.of(context).pop(newFriend);
              },
            ),
          ],
        ),
      ),
    );
  }
}
