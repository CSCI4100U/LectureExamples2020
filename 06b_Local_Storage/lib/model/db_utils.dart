import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'todo_manager.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE todo_items(id INTEGER PRIMARY KEY, item TEXT)');
      },
      version: 1,
    );
    return database;
  }
}
