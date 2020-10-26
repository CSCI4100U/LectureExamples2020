import 'package:flutter/material.dart';
import 'dart:async';

import 'model/todo.dart';
import 'model/todo_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'Local Storage'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _model = TodoModel();
  var _lastInsertedId = 0;
  var _todoItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(onChanged: (value) {
              _todoItem = value;
            }),
            RaisedButton(
              child: Text('Insert'),
              color: Colors.blue,
              onPressed: _addTodo,
            ),
            RaisedButton(
              child: Text('Update'),
              color: Colors.blue,
              onPressed: _updateTodo,
            ),
            RaisedButton(
              child: Text('Delete'),
              color: Colors.blue,
              onPressed: _deleteTodo,
            ),
            RaisedButton(
              child: Text('Read'),
              color: Colors.blue,
              onPressed: _readTodos,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addTodo() async {
    Todo todo = Todo(item: _todoItem);
    _lastInsertedId = await _model.insertTodo(todo);
    print('Todo inserted: $_lastInsertedId');
  }

  void _deleteTodo() {
    _model.deleteTodoWithId(_lastInsertedId);
  }

  void _updateTodo() {
    Todo todo = Todo(item: _todoItem);
    todo.id = _lastInsertedId;
    _model.updateTodo(todo);
  }

  Future<void> _readTodos() async {
    List<Todo> todos = await _model.getAllTodos();

    print('');
    print('Todos:');
    for (Todo todo in todos) {
      print(todo);
    }
  }
}
