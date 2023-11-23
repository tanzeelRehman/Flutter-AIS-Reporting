import 'dart:convert';

import 'package:ais_reporting/core/router/app_state.dart';
import 'package:ais_reporting/core/router/models/page_config.dart';
import 'package:ais_reporting/core/services/auth_services.dart';
import 'package:ais_reporting/core/services/secure_storage_service.dart';
import 'package:ais_reporting/core/utils/enums/page_state_enum.dart';
import 'package:ais_reporting/features/authentication/login/data/modals/login_response_modal.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/services/user_provider.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/globals/snack_bar.dart';
import '../../data/modals/login_request_model.dart';
import '../../domain/usecases/login_usecase.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._loginUsecase);

  //usecases
  final LoginUsecase _loginUsecase;

  //valuenotifiers

  ValueNotifier<bool> loginLoading = ValueNotifier(false);
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController loginEmailController = TextEditingController();
  bool isLoginButtonPressed = false;
  bool isLoginEmailError = false;
  LoginResponseModel? loginResponseModel;
  AuthServices authServices = sl();
  SecureStorageService secureStorageService = sl();
  UserProvider uSerProvider = sl();

  //login function
  Future<void> login() async {
    loginLoading.value = true;

    var params = LoginRequestModel(
        email: loginEmailController.text,
        password: loginPasswordController.text);
    var loginEither = await _loginUsecase(params);
    if (loginEither.isLeft()) {
      handleError(loginEither);
      loginLoading.value = false;
      print('false resz');
      notifyListeners();
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (r, previous) {
        loginResponseModel = r;
        uSerProvider.setLoggedInUser(loginResponseModel);
        secureStorageService.write(
            key: 'user', value: jsonEncode(loginResponseModel));
        notifyListeners();
        loginEmailController.clear();
        loginPasswordController.clear();
        AppState appState = sl();
        appState.goToNext(PageConfigs.dashboardPageConfig,
            pageState: PageState.replaceAll);
        Logger().v(loginResponseModel);
      });
      loginLoading.value = false;
    }
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) => ShowSnackBar.show(l.message), (r) => null);
  }
}
