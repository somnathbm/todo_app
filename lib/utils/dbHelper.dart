import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo.dart';

class DBHelper {
  String tblTodo = "todo";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colDate = "date";
  String colPriority = "priority";

  // declare a static variable with reference to internal ctor above
  static final DBHelper _dbHelper = DBHelper._internal();

  // declare a private named empty ctor
  DBHelper._internal();

  // finally create a factory ctor and return the internal instance
  factory DBHelper() {
    return _dbHelper;
  }

  static Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  // methods here
  /// Initialize the DB
  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todos.db';
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  /// Create the DB
  void _createDb(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)"
    );
  }

  /// Insert Todos item
  Future<int> insertTodo(Todo todo) async {
    Database db = await this.db;
    var result = await db.insert(tblTodo, todo.toMap());
    return result;
  }

  /// Get Todos item
  Future<List> getTodos() async {
    Database db = await this.db;
    var result = await db.rawQuery(
      "SELECT * FROM $tblTodo order by $colPriority ASC"
    );
    return result;
  }

  /// Get Todos count
  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
      await db.rawQuery("select count (*) from $tblTodo")
    );
    return result;
  }

  // Update Todos item
  Future<int> updateTodo(Todo todo) async {
    Database db = await this.db;
    var result = await db.update(tblTodo, todo.toMap(), where: "$colId = ?", whereArgs: [todo.getId]);
    return result;
  }

  // Delete a Todos item
  Future<int> deleteTodo(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete("DELETE FROM $tblTodo WHERE $colId = $id");
    return result;
  }
}