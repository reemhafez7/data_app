import 'package:data_app/database/controllers/notes_db_controller.dart';
import 'package:data_app/models/note.dart';
import 'package:data_app/models/process_response.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

//Observer  is Observing an Observable

class NotesGetXController extends GetxController  {

  //Reactive - Observable Array (obs)  المُراقَب
  RxList<Note> notes = <Note>[].obs;
  RxBool loading = false.obs;
  final NotesDbController _dbController = NotesDbController();

  static NotesGetXController get to => Get.find<NotesGetXController>();

  @override
  void onInit(){
    read();
    super.onInit();
  }

  //CRUD
  Future<ProcessResponse> create(Note note) async {
    int newRowId = await _dbController.create(note);
    if (newRowId != 0) {
      note.id = newRowId;
      notes.add(note);
      // notifyListeners();
      // update();

    }

    return ProcessResponse(
        newRowId != 0 ? "Operation completed" : "Operation failed!",
        newRowId != 0);
  }

  void read() async {
    loading.value = true;
    notes.value = await _dbController.read();
    loading.value = false;
    // notifyListeners();
    // update();
  }

  Future<ProcessResponse> updateNote(Note note) async {
    bool updated = await _dbController.update(note);
    if (updated) {
      int index = notes.indexWhere((element) => element.id == note.id);
      if (index != -1) {
        notes[index] = note;
        // notifyListeners();
        // update();
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
      // notifyListeners();
      // update();
    }
    return ProcessResponse(
      deleted ? "Deleted successfully" : "Delete failed",
      deleted,
    );
  }
}
