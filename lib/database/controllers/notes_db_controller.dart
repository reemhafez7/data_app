


import 'package:data_app/database/db_operations.dart';
import 'package:data_app/models/note.dart';

class NotesDbController extends DbOperations<Note> {

  @override
  Future<int> create(Note model) async {
    //SQL: INSERT INTO notes (title, info, user_id) VALUES ('title','info',1);
    // return await database.rawInsert(
    //     "INSERT INTO notes (title, info, user_id) VALUES (?, ?, ?)",
    //     [model.title, model.info, model.userId]);
    //*************************************************
    return await database.insert(Note.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    //DELETE FROM notes;
    //DELETE FROM notes WHERE id = 1 AND name = 'khaled';
    //DELETE FROM notes WHERE id = 1 OR name = 'khaled';
    // int countOfDeletedRows = await database.rawDelete("DELETE FROM notes WHERE id = ?", [id]);
    // return countOfDeletedRows == 1;
    //*************************************************
    int countOfDeletedRows =
        await database.delete(Note.tableName, where: "id = ?", whereArgs: [id]);
    return countOfDeletedRows == 1;
  }

  @override
  Future<List<Note>> read() async {
    //SQL: SELECT * FROM notes;
    // List<Map<String, dynamic>> rows = await database.rawQuery("SELECT * FROM notes");
    // return rows.map((rowMap) => Note.fromMap(rowMap)).toList();
    //*************************************************
    List<Map<String, dynamic>> rows = await database.query(Note.tableName);
    return rows.map((rowMap) => Note.fromMap(rowMap)).toList();
  }

  @override
  Future<Note?> show(int id) async {
    //SELECT * FROM notes WHERE id = 1;
    List<Map<String, dynamic>> rows = await database.rawQuery("SELECT * FROM notes WHERE id = ?", [id]);
    return rows.isNotEmpty ? Note.fromMap(rows.first) : null;
    //*************************************************
  }

  @override
  Future<bool> update(Note model) async {
    //UPDATE notes SET title = "new-title";
    //UPDATE notes SET title = "new-title" WHERE id = 1;
    // int countOfUpdatedRows = await database.rawUpdate(
    //     "UPDATE notes SET title = ?, info = ? WHERE id = ?",
    //     [model.title, model.info, model.userId]);
    // return countOfUpdatedRows == 1;
    //*************************************************
    int countOfUpdatedRows = await database.update(
        Note.tableName, model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
    return countOfUpdatedRows == 1;
  }
}

/**
 * SQL Queries:
 * - INSERT:
 *    - INSERT INTO tableName (c1, c2, c3) VALUES (v1, v2, v3)
 * - READ:
 *    - SELECT * FROM tableName;
 *    - SELECT * FROM tableName WHERE c1 = v1;
 *    - SELECT * FROM tableName WHERE c1 = v1 AND c2 = v2;
 *    - SELECT * FROM tableName WHERE c1 = v1 OR c2 = v2;
 *    - SELECT c1, c2 FROM tableName
 *    - SELECT c1, c2 FROM tableName WHERE c3 = v3
 * - UPDATE:
 *    - UPDATE tableName SET c1 = v1, c2 = v2, c3 = v3
 *    - UPDATE tableName SET c1 = v1, c2 = v2, c3 = v3 WHERE c1 = v1;
 * - DELETE:
 *    - DELETE FROM tableName
 *    - DELETE FROM tableName WHERE c1 = v1;
 */
