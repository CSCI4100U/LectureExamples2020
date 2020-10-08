import 'package:flutter/material.dart';

import 'drawer.dart';
import 'nav_page.dart';

class MoreWidgetsPage extends StatefulWidget {
  MoreWidgetsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MoreWidgetsPageState createState() => _MoreWidgetsPageState();
}

class _MoreWidgetsPageState extends State<MoreWidgetsPage> {
  List<NavPage> _pages = [
    NavPage(title: 'Add to Cart', icon: Icons.add_shopping_cart),
    NavPage(title: 'Saved Lists', icon: Icons.save),
    NavPage(title: 'Checkout', icon: Icons.card_membership),
  ];
  int _pageIndex = 0;

  List<String> _menuItems = ['New', 'Open', 'Save'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              print('Add to cart');

              // Navigate.of(context).push(AnotherPage(...))
            },
          ),
          IconButton(
            icon: Icon(Icons.remove_shopping_cart),
            onPressed: () {
              print('Remove from Cart');

              // Navigate.of(context).push(AnotherPage(...))
            },
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return _menuItems.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
            onSelected: (String value) {
              print('Selected menu item: ${value}');

              // use Navigation.of().push() to go to a different page
            },
          ),
        ],
      ),
      body: Center(),
      drawer: createDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Do Stuff',
        child: Icon(Icons.more_vert),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _pages.map((NavPage page) {
          return BottomNavigationBarItem(
            icon: Icon(page.icon),
            label: page.title,
          );
        }).toList(),
        onTap: (int index) {
          setState(() {
            _pageIndex = index;

            print('Switching to page $index');

            // Navigate.of(context).push(AnotherPage(...))
          });
        },
      ),
    );
  }
}
