import 'package:data_app/database/db_controller.dart';
import 'package:sqflite/sqflite.dart';

abstract class DbOperations<Model> {

  Database database = DBController().database;

  Future<int> create(Model model);

  Future<List<Model>> read();

  Future<Model?> show(int id);

  Future<bool> update(Model model);

  Future<bool> delete(int id);
}
