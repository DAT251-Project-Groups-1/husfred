import 'package:flutter/material.dart';
import 'package:frontend/src/screens/content/household.dart';
import 'package:frontend/src/screens/content/widgets/newTask.dart';

import 'content/feed.dart';
import 'content/todo.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  static List<Widget> _content = <Widget>[
    Todo(),
    Household(),
    Feed(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _content[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "Todo"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Household"),
          BottomNavigationBarItem(icon: Icon(Icons.view_agenda), label: "Feed"),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return NewTask();
            },
          );
        },
      ),
    );
  }
}
