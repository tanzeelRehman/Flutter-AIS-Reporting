
import 'package:ais_reporting/core/router/app_state.dart';
import 'package:ais_reporting/core/router/models/page_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/authentication/login/data/modals/login_response_modal.dart';

import '../utils/globals/globals.dart';
import 'auth_services.dart';

class UserProvider extends ChangeNotifier {
  final AuthServices _authServices = sl();
  LoginResponseModel? userDetails;
  Future logout(BuildContext context) async {
    _authServices.logoutUser(context);
  AppState appState=sl();
  appState.goToNext(PageConfigs.loginPageConfig);
  }

  void setLoggedInUser(LoginResponseModel? value) {
    userDetails = value;
    notifyListeners();
  }
}