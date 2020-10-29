import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'todo.dart';

class TodoList extends StatefulWidget {
  TodoList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> _todos;

  @override
  void initState() {
    super.initState();

    loadTodos();
  }

  Future<void> loadTodos() async {
    // GET /todos HTTP/1.1
    // ...
    var response = await http.get('https://jsonplaceholder.typicode.com/todos');

    // 200 OK
    // ...
    // todo data
    if (response.statusCode == 200) {
      setState(() {
        _todos = [];
        List todo_items = jsonDecode(response.body);
        for (var item in todo_items) {
          _todos.add(Todo.fromMap(item));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              List<Todo> newTodos = [];
              for (var todo in _todos) {
                if (!todo.completed) {
                  newTodos.add(todo);
                } else {
                  http.delete(
                      'https://jsonplaceholder.typicode.com/todos/${todo.id}');
                }
              }
              setState(() {
                _todos = newTodos;
              });
            },
          ),
        ],
      ),
      body: _createTodosList(),
    );
  }

  Widget _createTodosList() {
    if (_todos == null) {
      return CircularProgressIndicator();
    } else {
      return ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_todos[index].title),
            subtitle: Text(_todos[index].userId.toString()),
            leading: Checkbox(
              value: _todos[index].completed,
              onChanged: (bool value) {
                setState(() {
                  _todos[index].completed = value;
                });
              },
            ),
          );
        },
      );
    }
  }
}
