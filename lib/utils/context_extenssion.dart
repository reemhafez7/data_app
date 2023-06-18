import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

extension ContextExtenssion on BuildContext {
  void showSnackBar(String message, [bool error = false]) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
