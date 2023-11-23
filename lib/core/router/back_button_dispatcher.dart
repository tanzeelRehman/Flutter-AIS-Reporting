import 'package:flutter/material.dart';

import 'app_state.dart';

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  final AppState appState;

  AppBackButtonDispatcher(this.appState) : super();

  @override
  Future<bool> didPopRoute() async {
    appState.moveToBackScreen();
    return true;
  }
}
