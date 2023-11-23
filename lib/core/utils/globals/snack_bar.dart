import 'package:ais_reporting/core/utils/theme/color_style.dart';
import 'package:flutter/material.dart';

import 'globals.dart';

class ShowSnackBar {
  static show(String text) {
    if (text.isEmpty) {
      return;
    }

    final SnackBar snackBar = SnackBar(
      content: Text(text),
      backgroundColor: ColorsStyles.primaryColor,
      duration: const Duration(milliseconds: 3500),
    );
    snackbarKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
