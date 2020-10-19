import 'package:flutter/material.dart';

class Friend {
  String firstName;
  String lastName;
  String email;

  Friend({this.firstName, this.lastName, this.email});

  String toString() {
    return '$firstName $lastName';
  }
}

class FriendListBLoC with ChangeNotifier {
  List<Friend> _friends = [];

  List<Friend> get friends => _friends;

  set friends(List<Friend> newValue) {
    _friends = newValue;

    notifyListeners();
  }

  addFriend(Friend newFriend) {
    _friends.add(newFriend);

    notifyListeners();
  }
}
