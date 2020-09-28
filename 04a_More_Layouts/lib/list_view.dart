import 'package:flutter/material.dart';

Widget buildListView() {
  return ListView.separated(
    itemCount: 180,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 50,
        color: Colors.blue[100 + ((index % 9) * 100)],
        child: Center(child: Text('Entry $index')),
      );
    },
    separatorBuilder: (BuildContext context, int index) => Divider(),
  );
}
