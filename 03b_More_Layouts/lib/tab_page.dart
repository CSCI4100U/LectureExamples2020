import 'package:flutter/material.dart';

class LayoutExample {
  const LayoutExample({this.title, this.icon, this.builder});

  final String title;
  final IconData icon;
  final Function builder;
}

Widget buildTabBar(List<LayoutExample> options) {
  return TabBar(
    isScrollable: true,
    tabs: options.map<Widget>((LayoutExample option) {
      return Tab(
        text: option.title,
        icon: Icon(option.icon),
      );
    }).toList(),
  );
}

Widget buildTabBarView(var options) {
  return TabBarView(
    children: options.map<Widget>((LayoutExample option) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          child: option.builder(),
        ),
      );
    }).toList(),
  );
}
