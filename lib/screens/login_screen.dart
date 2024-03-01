import 'package:data_app/database/controllers/users_db_controller.dart';
import 'package:data_app/models/process_response.dart';
import 'package:data_app/prefs/shared_pref_controller.dart';
import 'package:data_app/provider/language_provider.dart';
import 'package:data_app/utils/context_extenssion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _emailLegnth = 0;

  String? _emailError;
  String? _passwordError;

  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  late String _language;

  @override
  void initState() {
    super.initState();
    _language =
        SharedPrefController().getValueFor<String>(PrefKeys.language.name) ??
            "en";
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.login),
        actions: [
          IconButton(
            onPressed: () => _showLanguageBottomSheet(),
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localizations.login_title,
              style: GoogleFonts.tajawal(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              context.localizations.login_sub_title,
              style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w300,
                  color: Colors.black45,
                  fontSize: 18,
                  height: 0.8),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailTextController,
              style: GoogleFonts.poppins(),
              keyboardType: TextInputType.emailAddress,
              //************************
              // textAlign: TextAlign.start,
              // textDirection: TextDirection.ltr,
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.done,
              textAlignVertical: TextAlignVertical.center,
              obscureText: false,
              obscuringCharacter: '*',
              //************************
              onChanged: (String value) {
                setState(() {
                  _emailLegnth = value.length;
                });
              },
              onSubmitted: (String value) => print(value),
              onTap: () => print("Tapped"),
              //************************
              showCursor: true,
              cursorColor: Colors.blue,
              // cursorHeight: 10,
              cursorWidth: 2,
              cursorRadius: const Radius.circular(0),
              //************************
              enabled: true,
              readOnly: false,
              //************************
              autocorrect: true,
              autofocus: false,
              //************************
              autofillHints: ['@gmail.com', '@hotmail.com'],
              enableSuggestions: true,
              //************************
              // maxLength: 30,
              // buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
              //   return null;
              //   // return Text('$currentLength :: $maxLength');
              // },
              //************************
              // minLines: 2,
              // maxLines: 2,
              //************************
              minLines: null,
              maxLines: null,
              expands: true,
              //************************
              decoration: InputDecoration(
                // counterText: '',
                // counterText: '$_emailLegnth/30',
                // counter: Text('${_emailLegnth}/30'),
                //************************
                // contentPadding: EdgeInsets.symmetric(horizontal: 20),
                contentPadding: EdgeInsets.zero,
                constraints: BoxConstraints(
                  maxHeight: _emailError == null ? 50 : 75,
                ),
                //************************
                hintText: context.localizations.email,
                hintStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                  fontSize: 14,
                ),
                hintMaxLines: 1,
                // hintTextDirection: TextDirection.ltr,
                //************************
                // labelText: 'Email',
                // labelStyle: GoogleFonts.poppins(
                //   fontWeight: FontWeight.w300,
                //   fontSize: 14,
                // ),
                // floatingLabelAlignment: FloatingLabelAlignment.start,
                // floatingLabelBehavior: FloatingLabelBehavior.never,
                // floatingLabelStyle: GoogleFonts.poppins(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 14,
                // ),
                // alignLabelWithHint: false,
                //************************
                fillColor: Colors.grey,
                filled: false,
                //************************
                // helperText: 'Ex: email@app.com',
                helperMaxLines: 1,
                helperStyle: GoogleFonts.poppins(
                  color: Colors.black45,
                  fontSize: 12,
                ),
                //************************
                enabled: false,
                //************************
                // icon: Icon(Icons.email),
                prefixIcon: const Icon(Icons.email),
                // prefixText: 'email-',
                // prefix: Text('email'),
                // prefixStyle: GoogleFonts.cabin(fontSize: 22),
                //************************
                // suffixIcon: IconButton(
                //   onPressed: () {},
                //   icon: Icon(Icons.send),
                // ),
                // suffixText: 'Available',
                // suffixStyle: GoogleFonts.poppins(
                //   fontSize: 12,
                //   color: Colors.grey,
                // ),
                // suffix: Text('TEXT'),
                //************************
                // border: UnderlineInputBorder(),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.blue.shade800),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2,
                      style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue.shade700,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                //************************
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red.shade400,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red.shade800,
                  ),
                ),
                errorText: _emailError,
                //************************
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordTextController,
              style: GoogleFonts.poppins(),
              obscureText: true,
              decoration: InputDecoration(
                constraints: BoxConstraints(
                  maxHeight: _passwordError == null ? 50 : 75,
                ),
                contentPadding: EdgeInsets.zero,
                hintText: context.localizations.password,
                hintStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.lock),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2,
                      style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue.shade700,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red.shade400,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red.shade800,
                  ),
                ),
                errorText: _passwordError,
                //************************
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _performLogin(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(context.localizations.login),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.localizations.no_account),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/register_screen"),
                  child: Text(
                    context.localizations.create_now,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    setState(() {
      _emailError = _emailTextController.text.isEmpty ? 'Enter email' : null;
      _passwordError =
          _passwordTextController.text.isEmpty ? 'Enter password' : null;
    });
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar("Enter required data", true);
    return false;
  }

  void _login() async {
    ProcessResponse response = await UsersDbController().login(_emailTextController.text, _passwordTextController.text);
    if(response.success) {
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
    context.showSnackBar(response.message, !response.success);
  }

  void _showLanguageBottomSheet() async {
    String? selectedLanguage = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Change Language",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Select suitable language",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                      const Divider(
                        height: 15,
                        color: Colors.black26,
                        thickness: 0.2,
                      ),
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "English",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        value: "en",
                        groupValue: _language,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _language = value);
                          }
                          Navigator.pop(context, "en");
                        },
                      ),
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "العربية",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        value: "ar",
                        groupValue: _language,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _language = value);
                          }
                          Navigator.pop(context, "ar");
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );

    if (selectedLanguage != null) {
      Provider.of<LanguageProvider>(context, listen: false)
          .changeLanguage(selectedLanguage);
    }
  }
}
