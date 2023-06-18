import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBController {
  DBController._();

  late Database _database;
  static DBController? _instance;

  factory DBController() {
    return _instance ??= DBController._();
  }

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "app_db.sql");
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database db) {},
      onCreate: (Database db, int version) async {
        db.execute("CREATE TABLE users ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT,"
            "email TEXT,"
            "password TEXT"
            ")");
        db.execute("CREATE TABLE notes ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title TEXT,"
            "info TEXT,"
            "user_id INTEGER,"
            "FOREIGN KEY (user_id) references users(id)"
            ")");
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {},
      onDowngrade: (Database db, int oldVersion, int newVersion) {},
    );
  }
}
