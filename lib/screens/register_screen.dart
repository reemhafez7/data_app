import 'package:data_app/database/controllers/users_db_controller.dart';
import 'package:data_app/models/process_response.dart';
import 'package:data_app/models/user.dart';
import 'package:data_app/utils/context_extenssion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _emailLegnth = 0;

  String? _emailError;
  String? _passwordError;

  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
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
        title: Text(context.localizations.register),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localizations.register_title,
              style: GoogleFonts.tajawal(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              context.localizations.register_sub_title,
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
                      strokeAlign: StrokeAlign.center,
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
                      strokeAlign: StrokeAlign.center,
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
              onPressed: () => _performRegister(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(context.localizations.register),
            ),
          ],
        ),
      ),
    );
  }

  void _performRegister() {
    if (_checkData()) {
      _register();
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

  void _register() async {
    ProcessResponse response = await UsersDbController().register(user);
    if(response.success) Navigator.pop(context);
    context.showSnackBar(response.message, !response.success);
  }

  User get user {
    User user = User();
    user.name = "Name";
    user.email = _emailTextController.text;
    user.password = _passwordTextController.text;
    return user;
  }
}
