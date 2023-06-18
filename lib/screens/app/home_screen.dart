import 'package:data_app/bloc/bloc/notes_bloc.dart';
import 'package:data_app/bloc/events/crud_event.dart';
import 'package:data_app/bloc/states/crud_state.dart';
import 'package:data_app/get/notes_getx_controller.dart';
import 'package:data_app/models/note.dart';
import 'package:data_app/prefs/shared_pref_controller.dart';
import 'package:data_app/screens/app/note_screen.dart';
import 'package:data_app/utils/context_extenssion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesBloc>(context).add(ReadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.home),
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(),
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NoteScreen(),
              ),
            ),
            icon: const Icon(Icons.note_add_outlined),
          ),
        ],
      ),
      body: BlocConsumer<NotesBloc, CrudState>(
        listenWhen: (previous, current) => current is ProcessState && current.type == ProcessType.delete,
        listener: (context, state) {
          state as ProcessState;
          context.showSnackBar(state.message, !state.success);
        },
        buildWhen: (previous, current) =>
        current is ReadState<Note> || current is LoadingState,
        builder: (context, state) {
          if(state is LoadingState){
            return const Center(child: CircularProgressIndicator());
          }else if (state is ReadState<Note> && state.data.isNotEmpty){
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return  ListTile(
                  leading: const Icon(Icons.note),
                  title: Text(state.data[index].title),
                  subtitle: Text(state.data[index].info),
                  trailing: IconButton(
                    onPressed: (){
                      BlocProvider.of<NotesBloc>(context).add(DeleteEvent(index));
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.red.shade800,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => NoteScreen(
                        note: state.data[index],
                      ),
                    ),
                    );
                  },
                );
              },
            );
          }else {
            return Center(
              child: Text('NO DATA' , style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black54,
              )),);
          }

        },
      ),
    );
  }



  void _showLogoutDialog() async {
    bool? result = await showDialog<bool>(
      barrierDismissible: false,
      barrierColor: Colors.black45,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
          icon: const Icon(Icons.question_mark),
          title: const Text("Confirm Logout"),
          content: const Text(
            "Are you sure?",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
    print("Result: $result");
    if (result ?? false) {
      await SharedPrefController().removeValueFor(PrefKeys.loggedIn.name);
      bool deleted = await Get.delete<NotesGetXController>();
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacementNamed(context, '/login_screen');
      });
    }
  }
}
