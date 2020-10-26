import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'db_utils.dart';
import 'todo.dart';

class TodoModel {
  Future<int> insertTodo(Todo todo) async {
    final db = await DBUtils.init();
    return db.insert(
      'todo_items',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await DBUtils.init();
    await db.update(
      'todo_items',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodoWithId(int id) async {
    final db = await DBUtils.init();
    await db.delete(
      'todo_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query('todo_items');
    List<Todo> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Todo.fromMap(maps[i]));
      }
    }
    return result;
  }

  Future<Todo> getTodoWithId(int id) async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'todo_items',
      where: 'id = ?',
      whereArgs: [id],
    );
    return Todo.fromMap(maps[0]);
  }
}
