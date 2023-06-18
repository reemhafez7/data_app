import 'package:data_app/bloc/events/crud_event.dart';
import 'package:data_app/bloc/states/crud_state.dart';
import 'package:data_app/database/controllers/notes_db_controller.dart';
import 'package:data_app/models/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


/// {@template bloc}
/// Takes a `Stream` of `Events` as input
/// and transforms them into a `Stream` of `States` as output.
/// {@endtemplate}
// class NotesBloc extends Bloc<Event, State> {
//   NotesBloc(super.initialState);
//
// }

class NotesBloc extends Bloc<CrudEvent, CrudState> {
  NotesBloc(super.initialState){
    
    // on<E extends Event>((E event, Emitter<State> emit) => null);
    on<CreateEvent<Note>>(_onCreateEvent);
    on<ReadEvent>(_onReadEvent);
    on<UpdateEvent<Note>>(_onUpdateEvent);
    on<DeleteEvent>(_onDeleteEvent);
    on<ShowEvent>(_onShowEvent);
  }

  List<Note> _notes = <Note> [] ;
  final NotesDbController _controller = NotesDbController();


  void _onCreateEvent(CreateEvent<Note> event, Emitter<CrudState> emit) async {
    int newRowId = await _controller.create(event.model);
    if(newRowId != 0){
      event.model.id = newRowId;
      _notes.add(event.model);
      emit(ReadState<Note>(_notes));
    }

    emit(ProcessState(
        newRowId != 0,
        newRowId != 0 ? "Operation success" : "Operation failed",
        ProcessType.create));
  }

  void _onReadEvent(ReadEvent event, Emitter<CrudState> emit) async {

    _notes = await _controller.read();
    emit(ReadState<Note>(_notes));

  }

  void _onUpdateEvent(UpdateEvent<Note> event, Emitter<CrudState> emit) async {
    bool updated = await _controller.update(event.model);
    if(updated){
      int index = _notes.indexWhere((element) => element.id == event.model.id);
      if(index != -1){
        _notes[index] = event.model;
        emit(ReadState<Note>(_notes));
      }
    }
    emit(ProcessState(updated, updated ? "Operation success" : "Operation failed", ProcessType.update));
  }

  void _onDeleteEvent(DeleteEvent event, Emitter<CrudState> emit) async {

    bool deleted = await _controller.delete(_notes[event.index].id);
    if(deleted){
      _notes.removeAt(event.index);
      emit(ReadState<Note>(_notes));
    }
    emit(ProcessState(deleted, deleted ? "Operation success" : "Operation failed", ProcessType.delete));

  }

  void _onShowEvent(ShowEvent event, Emitter<CrudState> emit) async {
    Note? note = await _controller.show(event.id);
    emit(ShowState<Note>(note));
  }
}