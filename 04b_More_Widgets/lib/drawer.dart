import 'package:flutter/material.dart';

Widget createDrawer() {
  return Drawer(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.blue[100 + (index * 100)],
            child: Center(
              child: FlatButton(
                child: Text('Item #${index + 1}'),
                onPressed: () {
                  print('Item ${index + 1} clicked');
                },
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    ),
  );
}
