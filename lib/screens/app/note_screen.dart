import 'package:data_app/bloc/bloc/notes_bloc.dart';
import 'package:data_app/bloc/events/crud_event.dart';
import 'package:data_app/bloc/states/crud_state.dart';
import 'package:data_app/models/note.dart';
import 'package:data_app/prefs/shared_pref_controller.dart';
import 'package:data_app/utils/context_extenssion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _titleTextController;
  late TextEditingController _infoTextController;

  // NotesGetXController controller = Get.find<NotesGetXController>();

  @override
  void initState() {
    super.initState();
    _titleTextController = TextEditingController(text: widget.note?.title);
    _infoTextController = TextEditingController(text: widget.note?.info);
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _infoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocListener<NotesBloc, CrudState>(
        listenWhen: (previous, current) =>
        current is ProcessState &&
            (current.type == ProcessType.create ||
             current.type == ProcessType.update),
        listener: (context, state) {
          state as ProcessState;
          context.showSnackBar(state.message, !state.success);
          if(state.success){
            state.type == ProcessType.create ? clear() : Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _titleTextController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: context.localizations.title,
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _infoTextController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: context.localizations.info,
                  prefixIcon: Icon(Icons.info),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _performSave(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: Text(context.localizations.save),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool get isNewNote => widget.note == null;

  String get title => isNewNote
      ? context.localizations.create_note
      : context.localizations.update_note;

  void _performSave() {
    if (_checkData()) {
      _save();
    }
  }

  bool _checkData() {
    if (_titleTextController.text.isNotEmpty &&
        _infoTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar("Enter required data", true);
    return false;
  }

  void _save() async {
    isNewNote
        ? BlocProvider.of<NotesBloc>(context).add(CreateEvent(note))
        : BlocProvider.of<NotesBloc>(context).add(UpdateEvent(note));
        
  }

  void clear() {
    _titleTextController.clear();
    _infoTextController.clear();
  }

  Note get note {
    Note note = isNewNote ? Note() : widget.note!;
    note.title = _titleTextController.text;
    note.info = _infoTextController.text;
    note.userId = SharedPrefController().getValueFor<int>(PrefKeys.id.name)!;

    return note;
  }
}
