import 'package:data_app/database/controllers/notes_db_controller.dart';
import 'package:data_app/models/note.dart';
import 'package:data_app/models/process_response.dart';
import 'package:flutter/material.dart';


class NotesProvider extends ChangeNotifier {
  List<Note> notes = <Note>[];
  final NotesDbController _dbController = NotesDbController();

  //CRUD
  Future<ProcessResponse> create(Note note) async {
    int newRowId = await _dbController.create(note);
    if (newRowId != 0) {
      note.id = newRowId;
      notes.add(note);
      notifyListeners();
    }
    return ProcessResponse(
        newRowId != 0 ? "Operation completed" : "Operation failed!",
        newRowId != 0);
  }

  void read() async {
    notes = await _dbController.read();
    notifyListeners();
  }

  Future<ProcessResponse> update(Note note) async {
    bool updated = await _dbController.update(note);
    if (updated) {
      int index = notes.indexWhere((element) => element.id == note.id);
      if (index != -1) {
        notes[index] = note;
        notifyListeners();
      }
    }
    return ProcessResponse(
      updated ? "Updated successfully" : "Update failed!",
      updated,
    );
  }

  Future<ProcessResponse> delete(int index) async {
    bool deleted = await _dbController.delete(notes[index].id);
    if (deleted) {
      notes.removeAt(index);
      notifyListeners();
    }
    return ProcessResponse(
      deleted ? "Deleted successfully" : "Delete failed",
      deleted,
    );
  }
}
