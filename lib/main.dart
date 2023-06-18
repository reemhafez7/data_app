import 'package:data_app/bloc/bloc/notes_bloc.dart';
import 'package:data_app/bloc/states/crud_state.dart';
import 'package:data_app/database/db_controller.dart';
import 'package:data_app/prefs/shared_pref_controller.dart';
import 'package:data_app/screens/app/home_screen.dart';
import 'package:data_app/screens/launch_screen.dart';
import 'package:data_app/screens/login_screen.dart';
import 'package:data_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferences();
  await DBController().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotesBloc(LoadingState())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            titleTextStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,



        ],
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        locale: Locale("en"),
        initialRoute: "/launch_screen",
        routes: {
          '/launch_screen': (context) => const LaunchScreen(),
          '/login_screen': (context) => const LoginScreen(),
          '/register_screen': (context) => const RegisterScreen(),
          '/home_screen': (context) => const HomeScreen(),
        },
      ),
    );

  }
}
