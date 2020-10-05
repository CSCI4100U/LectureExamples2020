import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: buildGridView(),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20.0),
      crossAxisSpacing: 2.0,
      mainAxisSpacing: 2.0,
      crossAxisCount: 3, // # of columns
      children: buildGridViewItems(27),
    );
  }

  List<Widget> buildGridViewItems(int count) {
    List<Widget> itemList = [];

    for (var i = 0; i < count; i++) {
      itemList.add(buildGridViewItem(i));
    }

    return itemList;
  } 

  Widget buildGridViewItem(int index) {
    Color colour = Colors.blue[100 + index * 100];
    if (index >= 9) {
      colour = Colors.red[100 + (index - 9) * 100];
    }
    if (index >= 18) {
      colour = Colors.green[100 + (index - 18) * 100];
    }
    return Container(
      height: 50,
      color: colour,
      child: Center(child: Text('Entry $index')),
    );
  }
}