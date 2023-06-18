import 'package:data_app/prefs/shared_pref_controller.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String language =
      SharedPrefController().getValueFor<String>(PrefKeys.language.name) ??
          "en";

  void changeLanguage(String language) {
    this.language = language;
    SharedPrefController().setLanguage(language);
    notifyListeners();
  }
}
